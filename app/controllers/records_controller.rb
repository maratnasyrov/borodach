class RecordsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:edit, :update, :status_online]

  expose(:work_day)
  expose(:record) 
  expose(:record_previous) { Record.find_by id: record.id-1 }
  expose(:record_next) { Record.find_by id: record.id+1 }
  expose(:day) { Day.find_by(id: work_day.day_id)  }
  expose(:month) { Month.find_by(id: day.month_id) }
  expose(:record_services) { record.record_services }
  expose(:record_service) { RecordService.new() }
  expose(:record_purchases) { record.record_purchases }
  expose(:record_purchase) { RecordPurchase.new() }
  expose(:record_shelves) { record.record_purchases }
  expose(:record_shelf) { RecordShelf.new() }
  expose(:finance)
  expose(:pre_record) { PreRecord.new() }
  expose(:master) { Master.find_by id: work_day.master_id }

  def update
    price_params = params["record"]
    price = price_params["price"]
    dinner = price_params["dinner"]
    client_name = price_params["client_name"]
    client_phone = price_params["client_phone"]

    if dinner.eql?("1")
      dinner_update(record, dinner_params(true), month, day)
    elsif dinner.eql?("0") && client_name.empty? && client_phone.empty?
      dinner_update(record, dinner_params(false), month, day)
    elsif (client_phone.eql?("") || client_phone.length < 11) && current_user.nil?
      redirect_to edit_work_day_record_path(work_day, record), notice: "Проверьте правильность введеных данных!"
    elsif price.nil?
      update_time(record, record_params, month, day)
    elsif price.empty?
      update_time(record, record_params, month, day)
    elsif check_price(record) == price.to_i
      closed_record(record) 
    else
      redirect_to month_day_path(month, day)
    end
  end

  def clear_record
    month_flag = find_month(record)
    day_flag = find_day(record)

    clear_status(record, clear_params, month_flag, day_flag)
  end

  def closed_record(record)
    month_flag = find_month(record)
    day_flag = find_day(record)

    closed_status(record, record_params, month_flag, day_flag)
  end

  def status_online
    record.update_attributes(status_online_params)
    work_day_flag = WorkDay.find_by id: record.work_day_id 

    redirect_to success_path
  end

  def change_payment_type
    record.payment_method.eql?("Карта") || record.payment_method.eql?("Card") ? payment_method = "Наличные" : payment_method = "Карта"

    record.update_attributes(payment_params(payment_method))

    record.finances.all.each do |finance|
      record.payment_method.eql?("Карта") || record.payment_method.eql?("Card") ? finance.update_attributes(cash_type: true) : finance.update_attributes(cash_type: false)
    end

    work_day_flag = WorkDay.find_by id: record.work_day_id

    redirect_to work_day_record_path(work_day_flag, record)
  end

  def open_record
    work_day_flag = WorkDay.find_by id: record.work_day_id

    if UserPolicy.new(current_user).superadmin?
      record.update_attributes(open_params)

      delete_finances_for_record(record, work_day_flag)
    else
      redirect_to work_day_record_path(work_day_flag, record)
    end
  end

  private

  def delete_finances_for_record(record, work_day_flag)
    record.finances.all.each do |finance|
      finance.destroy
    end

    record.shelf_histories.all.each do |shelf_history|
      shelf_flag = Shelf.find_by id: shelf_history.shelf_id

      shelf_flag.update_attributes(bulk: shelf_flag.bulk + shelf_history.number_changes)

      shelf_history.destroy
    end

    redirect_to work_day_record_path(work_day_flag, record)
  end

  def dinner_update(record, params, month, day)
    if RecordPolicy.new(record).status_closed?
      record.update_attributes(params)

      redirect_to month_day_path(month, day)
    else
      redirect_to month_day_path(month, day)
    end
  end

  def update_time(record, params, month, day)
    if RecordPolicy.new(record).status_closed?  
      start_time = params["start_time(4i)"]
      end_time = params["end_time(4i)"]
      update_records(record, start_time, end_time, params)
    else
      redirect_to month_day_path(month, day)
    end
  end

  def clear_status(record, params, month, day)
    work_day_flag = WorkDay.find_by(id: record.work_day_id)
    user_policy = UserPolicy.new(current_user)

    if RecordPolicy.new(record).status_closed? 
      record.update_attributes(params)

      purchases = record.record_purchases.all
      services = record.record_services.all
      shelves = record.record_shelves.all
      client = record.clients.first

      if !purchases.empty?
        purchases.each do |purchase|
          purchase.destroy
        end
      end

      if !services.empty?
        services.each do |service|
          service.destroy
        end
      end

      if !shelves.empty?
        shelves.each do |shelf|
          shelf.destroy
        end
      end

      if user_policy.all_rights?
        redirect_to month_day_path(month, day)
      elsif user_policy.master?
        redirect_to work_day_record_path(work_day_flag, record)
      end

      if !client.nil?
        client.update_attributes(number: client.number - 1)
      end
    else
      if user_policy.all_rights?
        redirect_to month_day_path(month, day)
      elsif user_policy.master?
        redirect_to work_day_record_path(work_day_flag, record)
      end
    end
  end

  def closed_status(record, parametrs, month, day)
    record_policy = RecordPolicy.new(record)
    user_policy = UserPolicy.new(current_user)
    work_day_flag = WorkDay.find_by(id: record.work_day_id)

    if record_policy.status_closed?
      record.update_attributes(parametrs)
      record.update_attributes(closed_record: true)

      work_day = WorkDay.find_by(id: record.work_day_id)
      master = Master.find_by(id: work_day.master_id)

      purchases = record.record_purchases.all
      record_services = record.record_services.all
      shelves = record.record_shelves.all
      client = record.clients.all.first

      if !record_services.empty?
        record_services.each do |record_service|
          service = Service.all.find_by(id: record_service.service_id)

          create_finances(master, record, service.price, service.id, "true")
        end
      end

      if !purchases.empty?       
        purchases.each do |purchase|
          find_purchase = Purchase.all.find_by(id: purchase.purchase_id)

          create_finances(master, record, find_purchase.price, find_purchase.id, "false")

          flag_number = find_purchase.number
          success = find_purchase.update_attributes(number: find_purchase.number - 1)
          if find_purchase.number - flag_number != 0
            PurchaseHistory.create(
              purchase_id: find_purchase.id,
              number_changes: find_purchase.number - flag_number,
              price: find_purchase.price,
              seller: master.name
            )   
          end
        end
      end

      if !shelves.empty?
        shelves.each do |shelf|
          shelf_flag = Shelf.all.find_by(id: shelf.shelf_id)
          flag_number = shelf_flag.number

          success = shelf_flag.update_attributes(bulk: shelf_flag.bulk - shelf.number) if shelf_flag.bulk > 0

          ShelfHistory.create(
              record_id: record.id,
              shelf_id: shelf_flag.id,
              number_changes: shelf.number,
              day_id: day.id,
              master_id: master.id
            ) if success
        end
      end

      if !client.nil?
        if client.number < 1
          ClientHistory.create(
            record_id: record.id,
            master_id: master.id,
            work_day_id: work_day.id,
            day_id: day.id,
            client_id: client.id,
            new_client: true)
        elsif client.number > 1
          ClientHistory.create(
            record_id: record.id,
            master_id: master.id,
            work_day_id: work_day.id,
            day_id: day.id,
            client_id: client.id,
            new_client: false)
        end
      end

      if user_policy.all_rights?
        redirect_to month_day_path(month, day)
      elsif user_policy.master?
        if !record_next.eql?(nil)
          redirect_to work_day_record_path(work_day_flag, record_next)
        else
          redirect_to work_day_record_path(work_day_flag, record)
        end
      end
    else
      if user_policy.all_rights?
        redirect_to month_day_path(month, day)
      elsif user_policy.master?
        if !record_next.eql?(nil)
          redirect_to work_day_record_path(work_day_flag, record_next)
        else
          redirect_to work_day_record_path(work_day_flag, record)
        end
      end
    end
  end

  def check_price(record)
    price = 0

    record.record_services.all.each do |record_service|
      service = Service.all.find_by(id: record_service.service_id)
      price += service.price
    end

    record.record_purchases.all.each do |record_purchase|
      purchase = Purchase.all.find_by(id: record_purchase.purchase_id)
      price += purchase.price
    end

    return price
  end

  def update_records(record, start_time, end_time, params)
    work_day_flag = WorkDay.find_by(id: record.work_day_id)
    record_policy = RecordPolicy.new(record)
    user_policy = UserPolicy.new(current_user)

    if record.start_time.hour != start_time.to_i
      record_id = 0

      if start_time.to_i < record.start_time.hour
        flag = record.start_time.hour - start_time.to_i
        record_id = record.id - flag
      elsif start_time.to_i > record.start_time.hour
        flag = start_time.to_i - record.start_time.hour
        record_id = record.id + flag
      else
        record_id = record.id
      end

      record_find = work_day.records.all.find_by(id: record_id)

      if record_find.dinner.eql?(false) && record_find.client_added.eql?(false)
        params["end_time(4i)"] = (start_time.to_i+1).to_s
        record_find.update_attributes(params)

        if !record.record_services.all.empty?
          record.record_services.all.each do |record_service|
            record_service.update_attributes(record_id: record_find.id)
          end
        end

        if !record.record_purchases.all.empty?
          record.record_purchases.all.each do |record_purchase|
            record_purchase.update_attributes(record_id: record_find.id)
          end
        end

        if !record.record_shelves.all.empty?
          record.record_shelves.all.each do |record_shef|
            record_shef.update_attributes(record_id: record_find.id)
          end
        end

        if !record.clients.first.nil?
          record.clients.first.update_attributes(record_id: record_find.id)
        end

        record.update_attributes(clear_params)
      elsif record_find.dinner.eql?(false) && record_find.client_added.eql?(false)
        record.update_attributes(params)
      end
    else
      record.update_attributes(params)

      {"Daily moisturizing shampoo" => 10, "Daily moisturizing conditioner" => 10, "Полотенца" => 2, "Лезвия" => 1, "Воротнички" => 1}.each do |name, number|
        success = shelf = Shelf.all.find_by name: name

        RecordShelf.create(shelf_id: shelf.id, record_id: record.id, number: number, day_id: day.id) if success
      end

      master = Master.find_by id: work_day.master_id

      add_client(master, record) if !record.client_phone.eql?("")
    end

    if current_user.eql?(nil)
      redirect_to edit_work_day_record_path(work_day, record)
    elsif user_policy.all_rights?
      redirect_to month_day_path(month, day)
    elsif user_policy.master?
      redirect_to work_day_record_path(work_day_flag, record)
    else
      redirect_to edit_work_day_record_path(work_day, record) , notice: "Проверьте правильность введеных данных!"
    end
  end

  def create_finances(master, record, price, service_id, service_type)
    finance_day = FinanceDay.all.find_by(day_id: day.id)

    if record.payment_method.eql?("Карта")
      payment_method = true
    else
      payment_method = false
    end

    type = true

    finance = Finance.create(
      master_id: master.id,
      day_id: day.id,
      price: price,
      finance_type: type,
      client_name: record.client_name,
      client_phone: record.client_phone,
      service_id: service_id,
      service_type: service_type,
      cash_type: payment_method,
      finance_day_id: finance_day.id,
      record_id: record.id)
    finance.save
  end

  def add_client(master, record)
    client_found = Client.find_by phone: record.client_phone

    if client_found.nil?
      client_new = Client.create(
        record_id: record.id,
        master_id: master.id,
        phone: record.client_phone,
        name: record.client_name,
        number: 0)

      client_new.save
    else
      client_found.update_attributes(number: client_found.number + 1, record_id: record.id)
    end
  end

  def price_time_update(record)
    price = 0
    record.record_services.all.each do |record_service|
      service = Service.all.find_by(id: record_service.service_id)
      price += service.price
    end

    record.update_attributes(price_params(price))
  end

  def payment_params(payment_method)
    {
      payment_method: payment_method
    }
  end

  def status_online_params
    {
      online: true,
      not_show: true
    }
  end

  def dinner_params(bool)
    if bool
      {
        dinner: true,
        not_show: true
      }
    elsif !bool
      {
        dinner: false,
        client_added: false,
        not_show: false
      }
    end
  end

  def open_params
    {
      closed_record: false
    }
  end

  def price_params(price)
    {
      price: price
    }
  end

  def clear_params
    {
      client_name: nil,
      client_phone: nil,
      discount: nil,
      client_added: false,
      online: false,
      not_show: false
    }
  end

  def record_params
    params.require(:record).permit(
      :client_name,
      :client_phone,
      :payment_method,
      :start_time,
      :end_time,
      :client_added,
      :discount,
      :price,
      :dinner,
      :online,
      :not_show,
      :closed_record).merge(work_day_id: work_day.id)
  end

  def find_month(record)
    day = find_day(record)
    month = Month.find_by(id: day.month_id)
    return month
  end

  def find_day(record)
    work_day = WorkDay.find_by(id: record.work_day_id)
    day = Day.find_by(id: work_day.day_id)
    return day
  end
end
