class WorkDayDecorator < ApplicationDecorator
  delegate_all

  def show_work_day_price
    sum = 0
    object.records.all.each do |record|
      record.finances.all.each do |finance|
        sum += finance.price
      end
    end

    "#{sum}"
  end

  def show_work_day_sale_price
    sum = 0
    object.records.all.each do |record|
      record.finances.all.each do |finance|
        sum += finance.price if finance.service_type.eql?(false)
      end
    end

    return sum
  end

  def show_work_day_service_price
    sum = 0
    object.records.all.each do |record|
      record.finances.all.each do |finance|
        sum += finance.price if finance.service_type.eql?(true)
      end
    end

    return sum
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
end
