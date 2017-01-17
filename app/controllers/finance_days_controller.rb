class FinanceDaysController < ApplicationController
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

  
  expose(:finance_day)
  expose(:finance) { Finance.new() }
  expose(:days)
  expose(:day)
  expose(:month) { Month.find_by(id: day.month_id) }


  def show_current_finance_day
    current_year = Date.today.year
    current_month = Date::MONTHNAMES[Date.today.month]
    current_day = Date.today.day

    year = Year.find_by number: current_year
    month = Month.find_by name_of_the_month: current_month, year_id: year.id
    day = Day.find_by number_of_the_day: current_day, month_id: month.id

    finance_day = FinanceDay.find_by day_id: day.id

    redirect_to day_finance_day_path(day, finance_day)
  end
end
