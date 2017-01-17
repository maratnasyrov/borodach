class DayDecorator < ApplicationDecorator
  delegate_all

  def show_all_consumption
    overall_consumption = 0
    object.finances.all.each do |finance|
      if finance.finance_type == false
        overall_consumption += finance.price
      end
    end

    "#{overall_consumption}"
  end

  def show_all_coming
    overall_coming = 0
    object.finances.all.each do |finance|
      if finance.finance_type == true
        overall_coming += finance.price
      end
    end

    "#{overall_coming}"
  end

  def show_all_card_transaction
    overall_card_transaction = 0
    object.finances.all.each do |finance|
      if finance.cash_type == true
        overall_card_transaction += finance.price
      end
    end

    "#{overall_card_transaction}"
  end

  def show_total
    show_all_coming.to_i - show_all_card_transaction.to_i - show_all_consumption.to_i
  end
end
