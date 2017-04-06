class ProductListDecorator < ApplicationDecorator
  delegate_all

  def status
    status = ""
    
    if object.closed_status == true
      status = "Добавлено на склад"
    else
      status = "Ожидает добавления"
    end
  end
end
