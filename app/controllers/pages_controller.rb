class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :success_online, :about, :info]

  expose(:masters) { Master.all }

  expose(:current_year) { Year.find_by number: Date.today.year }
  expose(:current_month) { Month.find_by name_of_the_month: Date::MONTHNAMES[Date.today.month], year_id: current_year.id }
  expose(:next_month) { Month.find_by id: current_month.id+1 }

  expose(:two_month) { [current_month, next_month] }
  expose(:masters) { Master.all }
  expose(:landing_images) { LandingImage.all }

  def success_online
    render "success_online"
  end

  def info
    file_path = "https://s3.amazonaws.com/svp-kzn/info/Davayte_znakomitsya.pdf"
    
    redirect_to file_path
  end
end
