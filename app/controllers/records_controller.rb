class RecordsController < ApplicationController
  expose(:work_day)
  expose(:record) 
  expose(:day) { Day.find_by(id: work_day.day_id)  }
  expose(:month) { Month.find_by(id: day.month_id) }
  expose(:record_services) { record.record_services }
  expose(:record_purchases) { record.record_purchases }
  expose(:finance)

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
    elsif price.nil?
      update_time(record, record_params, month, day)
    elsif price.empty?
      update_time(record, record_params, month, day)
    else
      closed_record(record)
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

  private

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
    if RecordPolicy.new(record).status_closed? 
      record.update_attributes(params)

      purchases = record.record_purchases.all
      services = record.record_services.all

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

      redirect_to month_day_path(month, day)
    else
      redirect_to month_day_path(month, day)
    end
  end

  def closed_status(record, parametrs, month, day)
    if RecordPolicy.new(record).status_closed?
      record.update_attributes(parametrs)
      record.update_attributes(closed_record: true)

      work_day = WorkDay.find_by(id: record.work_day_id)
      master = Master.find_by(id: work_day.master_id)

      purchases = record.record_purchases.all
      record_services = record.record_services.all

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

      redirect_to month_day_path(month, day)
    else
      redirect_to month_day_path(month, day)
    end
  end

  def update_records(record, start_time, end_time, params)
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

        record.update_attributes(clear_params)
      elsif record_find.dinner.eql?(false) && record_find.client_added.eql?(false)
        record.update_attributes(params)
      end
    else
      record.update_attributes(params)
    end

    redirect_to month_day_path(month, day)
  end

  def create_finances(master, record, price, service_id, service_type)
    finance_day = FinanceDay.all.find_by(day_id: day.id)

    if record.payment_method.eql?("Card")
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

  def price_time_update(record)
    price = 0
    record.record_services.all.each do |record_service|
      service = Service.all.find_by(id: record_service.service_id)
      price += service.price
    end

    record.update_attributes(price_params(price))
  end

  def dinner_params(bool)
    if bool
      {
        dinner: true
      }
    elsif !bool
      {
        dinner: false,
        client_added: false
      }
    end
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
      client_added: false
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
