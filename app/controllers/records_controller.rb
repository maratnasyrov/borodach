class RecordsController < ApplicationController
  expose(:work_day)
  expose(:record, attributes:  :record_params) 

  def update
    record.update_attributes(record_params)
    
    redirect_to now_path
  end

  private

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
