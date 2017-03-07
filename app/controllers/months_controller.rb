class MonthsController < ApplicationController  
  expose(:months)

  expose(:year) { Year.find_by number: Date.today.year }
  expose(:next_year) { Year.find_by number: year .number + 1 }
  expose(:last_year) do
    if year.number != Year.all.first.number
      Year.find_by number: year.number  - 1 
    else
      Year.find_by number: year.number
    end
  end
  expose(:year_search) { Year.year_search(month.year_id).first }

  expose(:month)
  expose(:current_month) { Date::MONTHNAMES[Date.today.month] }

  expose(:masters) { Master.all }
  expose(:master)

  expose(:work_day) { WorkDay.new() }

  expose(:salons) { Salon.all }

  expose(:second_part_of_the_month) { month.days.all - month.days.first(15) }

  def fill_schedule
    current_year = Date.today.year
    year = Year.find_by number: current_year
    month_flag = Month.find_by name_of_the_month: current_month, year_id: year.id

    redirect_to month_path(month_flag)
  end
end
