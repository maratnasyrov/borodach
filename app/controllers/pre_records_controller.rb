class PreRecordsController < ApplicationController
  expose(:pre_records)
  expose(:pre_record, attributes: :pre_record_params)
  expose(:record)
  expose(:work_day) { WorkDay.all.find_by id: record.work_day_id }
  expose(:day) { Day.all.find_by id: work_day.day_id  }

  def create
    after = params["pre_record"]["after"]
    phone = record.client_phone

    params["pre_record"]["client_name"] = record.client_name
    params["pre_record"]["client_phone"] = phone
    params["pre_record"]["master_id"] = work_day.master_id

    if !phone.empty?
      if after.eql?("3 недели")
        create_pre_record(21, record)
      elsif after.eql?("2 недели")
        create_pre_record(14, record)
      elsif after.eql?("1 неделя")
        create_pre_record(7, record)
      elsif after.eql?("")
        respond_with work_day, record
      end
    else
      respond_with work_day, record
    end
  end

  def destroy
    day = Day.find_by id: pre_record.day_id
    month = Month.find_by id: day.month_id
    success = pre_record.destroy

    redirect_to month_day_path(month, day) if success
  end

  private

  def create_pre_record(number, record)
    pre_record = PreRecord.create(pre_record_params(number))
    pre_record.save

    respond_with work_day, record
  end

  def pre_record_params(number)
    params.require(:pre_record).permit(:client_name, :client_phone, :after, :master_id).merge(day_id: day.id  + number, record_id: record.id)
  end
end
