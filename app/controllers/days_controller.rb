class DaysController < ApplicationController
  expose(:month)

  expose(:days)
  expose(:day, attributes: :days_params)

  expose(:work_days) { day.work_days }
  expose(:work_day)

  expose(:masters) { Master.all }

  expose(:record)
  
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
