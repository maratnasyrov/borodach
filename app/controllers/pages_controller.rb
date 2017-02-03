class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  expose(:masters) { Master.all }

  expose(:current_year) { Year.find_by number: Date.today.year }
  expose(:current_month) { Month.find_by name_of_the_month: Date::MONTHNAMES[Date.today.month], year_id: current_year.id }
  expose(:next_month) { Month.find_by id: current_month.id+1 }

  expose(:two_month) { [current_month, next_month] }
  expose(:masters) { Master.all }
end
