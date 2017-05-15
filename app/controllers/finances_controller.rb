class FinancesController < ApplicationController
  expose(:finance)
  expose(:day)
  expose(:finance_day)

  def create
    cash_params = params["finance"]["cash_type"]
    finance_type_params = params["finance"]["finance_type"]

    if cash_params.eql?("Наличные")
      params["finance"]["cash_type"] = "false"
    else
      params["finance"]["cash_type"] = "true"
    end

    if finance_type_params.eql?("Приход")
      params["finance"]["finance_type"] = "true"
    else
      params["finance"]["finance_type"] = "false"
    end

    finance = Finance.create(finances_params)
    success = finance.save

    day = Day.find_by id: finance.day_id
    finance_day = FinanceDay.find_by id: finance.finance_day_id

    redirect_to day_finance_day_path(day, finance_day) if success
  end

  def destroy
    day = Day.find_by id: finance.day_id
    finance_day = FinanceDay.find_by id: finance.finance_day_id

    success = finance.destroy

    redirect_to day_finance_day_path(day, finance_day) if success
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
      :cash_type,
      :day_id,
      :finance_day_id,
      :finance_type,
      :comment,
      :salon_id)
  end
end
