class FinancesController < ApplicationController
  expose(:finance)

  def create
    finance = Finance.create(finances_params)
    finance.save
  end

  def show_current_finance_day
    current_year = Date.today.year
    current_month = Date::MONTHNAMES[Date.today.month]
    current_day = Date.today.day

    year = Year.find_by number: current_year
    month = Month.find_by name_of_the_month: current_month, year_id: year.id
    day = Day.find_by number_of_the_day: current_day, month_id: month.id

    redirect_to day_finance_path(day)
  end

  private

  def finances_params
    params.require(:finance).permit(
      :master_id,
      :price,
      :type,
      :client_name,
      :client_phone,
      :service_id,
      :service_type,
      :cash_type)
  end
end
