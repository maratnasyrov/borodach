class ShelfHistoriesController < ApplicationController
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
  expose(:days)
  expose(:day)
  expose(:month) { Month.find_by(id: day.month_id) }
  expose(:work_days) { day.work_days.all }

  expose(:shelf_histories)
  expose(:shelf_history)
end
