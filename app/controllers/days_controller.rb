class DaysController < ApplicationController
  expose(:year) { Year.find_by number: Date.today.year }
  expose(:next_year) { Year.find_by number: year .number + 1 }
  expose(:last_year) do
    if year.number != Year.all.first.number
      Year.find_by number: year.number  - 1 
    else
      Year.find_by number: year.number
    end
  end
  expose(:month)

  expose(:year_search) { Year.year_search(month.year_id).first }

  expose(:days)
  expose(:day, attributes: :days_params)

  expose(:work_days) { day.work_days }
  expose(:work_day)

  expose(:masters) { Master.all }

  expose(:record)

  expose(:record_services) { RecordServices.all }
  expose(:record_service) { RecordService.new() }

  expose(:record_purchases) { RecordPurchases.all }
  expose(:record_purchase) { RecordPurchase.new() }
  expose(:pre_record) { PreRecord.new() }
  
  def show_current_date
    current_year = Date.today.year
    current_month = Date::MONTHNAMES[Date.today.month]
    current_day = Date.today.day

    year = Year.find_by number: current_year
    month = Month.find_by name_of_the_month: current_month, year_id: year.id
    day = Day.find_by number_of_the_day: current_day, month_id: month.id

    redirect_to month_day_path(month, day)
  end

  private

  def days_params
    params.require(:day).permit(:number_of_the_day, :month_id)
  end
end
