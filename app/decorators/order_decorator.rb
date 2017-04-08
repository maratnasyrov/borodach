class OrderDecorator < ApplicationDecorator
  delegate_all

  def order_status
    status = ""

    if object.closed_status == true
      status = "Закрыт"
    elsif check_sum?
      status = "Готов к отправке"
    else
      status = "Пополнение"
    end

    return status
  end

  def check_sum?
    sum = 0

    object.product_lists.all.each do |product_list|
      sum += product_list.price
    end

    if sum >= 5000
      return true
    else
      return false
    end
  end

  def total_price
    sum = 0

    object.product_lists.all.each do |product_list|
      sum += product_list.price
    end

    return "Общая сумма: #{sum}"
  end
end
