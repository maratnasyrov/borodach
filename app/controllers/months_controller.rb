class MonthsController < ApplicationController  
  expose(:months)

  expose(:year) { Year.find_by number: Date.today.year }
  expose(:month)

  expose(:masters) { Master.all }
  expose(:master)

  expose(:work_day) { WorkDay.new() }
end
