class FinanceDecorator < ApplicationDecorator
  delegate_all

  def show_service_type
    if object.service_type.eql?(true)
      "#{Service.find_by(id: object.service_id).name}"
    else
      "#{Purchase.find_by(id: object.service_id).name}"
    end
  end
end
