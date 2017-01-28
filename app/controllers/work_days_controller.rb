class WorkDaysController < ApplicationController
  expose(:work_days) {WorkDay.all}
  expose(:work_day)

  expose(:masters) { Master.all }
  expose(:master)

  expose(:day)

  expose(:months) { Month.all}
  expose(:month)

  expose(:record) { Record.update() }

  def create
    work_day = WorkDay.create(master_id: master.id, day_id: day.id)
    success = work_day.save

    day = Day.find_by(id: work_day.day_id)
    month = Month.find_by(id: day.month_id)
    year = Year.find_by(id: month.year_id)

    finance_day= FinanceDay.create(day_id: day.id, month_id: month.id)
    finance_day.save

    work_day.create_records if success

    redirect_to month_path(day.month_id)
  end

  def destroy
    day = Day.find_by(id: work_day.day_id)
    month = Month.find_by(id: day.month_id)

    if WorkDayPolicy.new(work_day).smth_records_added?
      success = work_day.destroy
      redirect_to month_path(month) if success
    else
      redirect_to month_path(month)
    end
  end
end
