class MonthDecorator < ApplicationDecorator
  delegate_all

  def day_of_the_previous_month
    previous_month = Month.find_by id: object.id - 1

    year = Year.find_by id: previous_month.year_id
    day = previous_month.days.last

    year_number = year.number
    month_number = object.number-1
    day_number = day.number_of_the_day

    check_date = Time.new(year_number, month_number, day_number).to_date

    return check_date.wday
  end

  def first_week
    first_week = []

    if day_of_the_previous_month == 7
      first_week = object.days.first
    else
      first_week = object.days.first(7 - day_of_the_previous_month)

      for i in 0..day_of_the_previous_month-1
        first_week.insert(0,nil)
      end
    end

    return first_week
  end

  def second_week
    second_week = object.days - first_week

    return second_week.first(7)
  end

  def third_week
    third_week = object.days - second_week - first_week

    return third_week.first(7)
  end

  def fourth_week
    fourth_week = object.days - third_week - second_week - first_week

    return fourth_week.first(7)
  end

  def fifth_week
    fifth_week = object.days - fourth_week - third_week - second_week - first_week
    
    for i in 0..7 - fifth_week.length-1
      fifth_week.insert(-1, nil)
    end
    
    return fifth_week.first(7)
  end

  def first_salary(master)
    sum = 0
    first_part_of_the_week = object.days.first(15)

    first_part_of_the_week.each do |day|
      day.work_days.masters_work_days(master).each do |work_day|
        sum += work_day.decorate.show_work_day_service_price
      end
    end

    return sum
  end

  def first_sale(master)
    sum = 0
    first_part_of_the_week = object.days.first(15)

    first_part_of_the_week.each do |day|
      day.work_days.masters_work_days(master).each do |work_day|
        sum += work_day.decorate.show_work_day_sale_price
      end
    end

    return sum
  end

  def second_salary(master)
    sum = 0
    first_part_of_the_week = object.days.first(15)
    second_part_of_the_week = object.days.all - first_part_of_the_week

    second_part_of_the_week.each do |day|
      day.work_days.masters_work_days(master).each do |work_day|
        sum += work_day.decorate.show_work_day_service_price
      end
    end

    return sum
  end

  def second_sale(master)
    sum = 0
    first_part_of_the_week = object.days.first(15)
    second_part_of_the_week = object.days.all - first_part_of_the_week

    second_part_of_the_week.each do |day|
      day.work_days.masters_work_days(master).each do |work_day|
        sum += work_day.decorate.show_work_day_sale_price
      end
    end

    return sum
  end

  def first_salary_with_percent(master)
    return (first_salary(master) * 0.35).round
  end

  def second_salary_with_percent(master)
    return (second_salary(master) * 0.35).round
  end

  def all_sale(master)
    sum = 0

    object.days.all.each do |day|
      day.work_days.masters_work_days(master).each do |work_day|
        sum += work_day.decorate.show_work_day_sale_price
      end
    end

    return (sum*0.1).round
  end

  def percents(master)
    all_salary = first_salary_with_percent(master) + second_salary_with_percent(master)
    all_master_money_in_month = first_salary(master) + second_salary(master)
    sum = 0
    percent = "35%"

    if all_master_money_in_month >= 110000
      sum = (all_master_money_in_month*0.41).round - first_salary_with_percent(master)
      percent = "41%"
    elsif all_master_money_in_month >= 100000 && all_master_money_in_month < 110000
      sum = (all_master_money_in_month*0.4).round - first_salary_with_percent(master)
      percent = "40%"
    elsif all_master_money_in_month >= 90000 && all_master_money_in_month < 100000
      percent = "39%"
      sum = (all_master_money_in_month*0.39).round - first_salary_with_percent(master)
    elsif all_master_money_in_month >= 80000 && all_master_money_in_month < 90000
      percent = "38%"
      sum = (all_master_money_in_month*0.38).round - first_salary_with_percent(master)
    elsif all_master_money_in_month >= 70000 && all_master_money_in_month < 80000
      percent = "37%"
      sum = (all_master_money_in_month*0.37).round - first_salary_with_percent(master)
    elsif all_master_money_in_month >= 60000 && all_master_money_in_month < 70000
      percent = "36%"
      sum = (all_master_money_in_month*0.36).round - first_salary_with_percent(master)
    elsif all_master_money_in_month < 60000
      sum = (all_master_money_in_month*0.35).round - first_salary_with_percent(master)
    end

    return percent, sum
  end

  def output_salary_info(master)
    percents = percents(master)
    percent = percents.first
    sum = percents.second
    return "c учетом #{percent}: #{sum} р."
  end
end
