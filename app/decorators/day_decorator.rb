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

  def show_salon_consumption(salon_id)
    overall_consumption = 0
    object.finances.all.each do |finance|
      if finance.salon_id = salon_id
        if finance.finance_type == false
          overall_consumption += finance.price
        end
      end
    end

    "#{overall_consumption}"
  end

  def show_only_coming
    overall_consumption = 0
    object.finances.all.each do |finance|
      if finance.finance_type == true && finance.service_type.nil?
        overall_consumption += finance.price
      end
    end

    "#{overall_consumption}"
  end

  def show_salon_only_coming(salon_id)
    overall_consumption = 0
    object.finances.all.each do |finance|
      if finance.salon_id == salon_id
        if finance.finance_type == true && finance.service_type.nil?
          overall_consumption += finance.price
        end
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

  def show_salon_all_coming(salon_id)
    overall_coming = 0
    object.finances.all.each do |finance|
      if finance.salon_id == salon_id
        if finance.finance_type == true
          overall_coming += finance.price
        end
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

  def show_salon_all_card_transaction(salon_id)
    overall_card_transaction = 0
    object.finances.all.each do |finance|
      if finance.salon_id == salon_id
        if finance.cash_type == true
          overall_card_transaction += finance.price
        end
      end
    end

    "#{overall_card_transaction}"
  end

  def show_total
    show_all_coming.to_i - show_all_card_transaction.to_i - show_all_consumption.to_i
  end

  def show_salon_total(salon_id)
    show_salon_all_coming(salon_id).to_i - show_salon_all_card_transaction(salon_id).to_i - show_salon_consumption(salon_id).to_i
  end

  def show_date
    "#{object.number_of_the_day} #{Month.find_by(id: object.month_id).name_of_the_month}"
  end

  def show_date_number
    "#{object.number_of_the_day}.#{Month.find_by(id: object.month_id).number}"
  end

  def full_date
    month_flag = Month.find_by id: object.month_id
    year_flag = Year.find_by id: month_flag.year_id

    day = ""
    month = ""

    if object.number_of_the_day.to_s.length == 1
      day_flag = "0" + object.number_of_the_day.to_s
    else
      day_flag = object.number_of_the_day
    end

    if month_flag.number.to_s.length == 1
      month = "0" + month_flag.number.to_s
    end

    return "#{day_flag}.#{month}.#{year_flag.number}"
  end
end
