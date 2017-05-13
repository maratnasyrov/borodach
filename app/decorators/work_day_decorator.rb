class WorkDayDecorator < ApplicationDecorator
  delegate_all

  def current_record
    hour_now = Time.now.hour
    client_name = ""

    object.records.all.each do |record|
      if record.start_time.hour == hour_now
        if !record.client_name.nil?
          client_name = record.client_name
        else
          client_name = "Z z z"
        end
      end
    end

    return client_name
  end

  def next_record
    hour_next = Time.now.hour + 1
    client_name = ""

    object.records.all.each do |record|
      if record.start_time.hour == hour_next
        if !record.client_name.nil?
          client_name = record.client_name
        else
          client_name = "Z z z"
        end
      end
    end

    return client_name
  end

  def show_work_day_price
    sum = 0
    object.records.all.each do |record|
      record.finances.all.each do |finance|
        sum += finance.price
      end
    end

    return sum
  end

  def show_work_day_sale_price
    show_money("sales")
  end

  def show_work_day_service_price
    show_money("services")
  end

  def show_money(type)
    working_shift = WorkingShift.find_by master_id: object.master_id, day_id: object.day_id

    if working_shift != nil
      if type.eql?("sales")
        return working_shift.sales
      elsif type.eql?("services")
        return working_shift.services
      end
    else
      return 0
    end
  end

  def new_clients
    number = 0

    object.client_histories.all.each do |client_history|
      client = Client.find_by id: client_history.client_id

      number += 1 if client_history.new_client == true
    end 

    return number
  end

  def old_clients
    number = 0

    object.client_histories.all.each do |client_history|
      client = Client.find_by id: client_history.client_id

      number += 1 if client_history.new_client == false
    end 

    return number
  end

  def client_statistic
    "Новых: #{new_clients} Старых: #{old_clients}"
  end

  def show_address
    "#{Salon.find_by(id: object.salon_id).address}"
  end
end
