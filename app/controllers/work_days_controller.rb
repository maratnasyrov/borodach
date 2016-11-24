class WorkDaysController < ApplicationController
  expose(:work_days) {WorkDay.all}
  expose(:work_day)

  expose(:masters) { Master.all }
  expose(:master)

  expose(:day)
  expose(:current_month) { Date::MONTHNAMES[Date.today.month] }

  expose(:months) { Month.all}
  expose(:month)

  def create
    work_day = WorkDay.create(master_id: master.id, day_id: day.id)
    success = work_day.save

    redirect_to month_path(day.month_id) if success
  end

  def destroy
    day = Day.find_by(id: work_day.day_id)
    month = Month.find_by(id: day.month_id)

    success = work_day.destroy
    redirect_to month_path(month) if success
  end

  def fill_schedule
    current_year = Date.today.year
    year = Year.find_by number: current_year
    month = Month.find_by name_of_the_month: current_month, year_id: year.id

    render 'fill_schedule', locals: { year: year, month: month }
  end
end
