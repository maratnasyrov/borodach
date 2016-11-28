class RecordsController < ApplicationController
  expose(:work_day)
  expose(:record, attributes:  :record_params) 
  expose(:day) { Day.find_by(id: work_day.day_id)  }
  expose(:month) { Month.find_by(id: day.month_id) }

  def update
    if RecordPolicy.new(record).status_closed?
      record.update_attributes(record_params)

      redirect_to month_day_path(month, day)
    else
      redirect_to month_day_path(month, day)
    end
  end

  def clear_record
    month_flag = find_month(record)
    day_flag = find_day(record)

    if RecordPolicy.new(record).status_closed?
      record.update_attributes(clear_params)
      
      redirect_to month_day_path(month_flag, day_flag)
    else
      redirect_to month_day_path(month_flag, day_flag)
    end
  end

  def closed_record
    month_flag = find_month(record)
    day_flag = find_day(record)

    if RecordPolicy.new(record).status_closed?
      record.update_attributes(closed_params)
      redirect_to month_day_path(month_flag, day_flag)
    else
      redirect_to month_day_path(month_flag, day_flag)
    end
  end

  private

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

  def record_params
    params.require(:record).permit(
      :client_name,
      :client_phone,
      :payment_method,
      :time_start,
      :time_end,
      :client_added,
      :discount,
      :price,
      :closed_record).merge(work_day_id: work_day.id)
  end
end
