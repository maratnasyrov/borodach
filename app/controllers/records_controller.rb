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
      record.update_attributes(params)
      price_time_update(record)

      redirect_to month_day_path(month, day)
    else
      redirect_to month_day_path(month, day)
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
