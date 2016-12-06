class RecordsController < ApplicationController
  expose(:work_day)
  expose(:record, attributes:  :record_params) 
  expose(:day) { Day.find_by(id: work_day.day_id)  }
  expose(:month) { Month.find_by(id: day.month_id) }
  expose(:record_services) { record.record_services }

  def update
    check_status(record, record_params, month, day)
  end

  def clear_record
    month_flag = find_month(record)
    day_flag = find_day(record)

    check_status(record, clear_params, month_flag, day_flag)
  end

  def closed_record
    month_flag = find_month(record)
    day_flag = find_day(record)

    check_status(record, closed_params, month_flag, day_flag)
  end

  private

  def check_status(record, params, month, day)
    if RecordPolicy.new(record).status_closed?  
      start_time = params["start_time(4i)"]
      update_records(record, start_time, params)

      redirect_to month_day_path(month, day)
    else
      redirect_to month_day_path(month, day)
    end
  end

  def update_records(record, start_time, params)
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

    if record.start_time.hour != start_time.to_i 
      record_find.update_attributes(params)

      if !record.record_services.all.empty?
        record.record_services.all.each do |record_service|
          record_service.update_attributes(record_id: record_find.id)
        end
      end

      record.update_attributes(clear_params)
    else
      record.update_attributes(params)
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

  def closed_params
    {
      discount: record.discount,
      price: record.price,
      payment_method: record.payment_method,
      closed_record: true
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
