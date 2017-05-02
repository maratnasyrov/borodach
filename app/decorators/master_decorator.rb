class MasterDecorator < ApplicationDecorator
  delegate :id, :name, :last_name

  def master_info
    "#{object.name} #{object.last_name}"
  end

  def show_shelf_history(day_id)
    history_hash = {}

    object.shelf_histories.find_day(day_id).each do |shelf_history|
      shelf_name = Shelf.find_by(id: shelf_history.shelf_id).name
      number_changes = shelf_history.number_changes

      add_hash = { "#{shelf_name}" => number_changes }
      history_hash.merge!(add_hash) { |key, oldval, newval| newval + oldval }
    end

    return history_hash
  end

  def service_info
    info = object.about_master.split(";")

    return info
  end

  def services_in_about_master
    description = [service_info.first]
    about_services =  service_info - description
    hash_services = {}
    about_services.each do |about_service|
      info = about_service.split("-")
      info.first.slice! "\r\n"

      key = info.first
      value = info.second

      hash_services[key] = value
    end

    return description.first, hash_services
  end

  def first_salary(month)
    month_salary = MonthSalary.find_by master_id: object.id, month_id: month.id

    if month_salary != nil
      sum = 0

      month_salary.working_shifts.each do |working_shift|
        day_flag = Day.find_by id: working_shift.day_id

        if day_flag.number_of_the_day <= 15
          sum += working_shift.services
        end
      end

      return month_salary.services, sum
    else
      return 0
    end
  end

  def second_salary(month)
    first_salary_array = first_salary(month)

    if first_salary_array != 0
      return first_salary_array.first - first_salary_array.last
    else
      return 0
    end
  end

  def first_salary_with_percent(month)
    first_salary = first_salary(month)
    if first_salary != 0
      return (first_salary.last * 0.35).round
    else
      return 0
    end
  end

  def all_sales_without_percent(month)
    month_salary = MonthSalary.find_by master_id: object.id, month_id: month.id

    if month_salary != nil
      return month_salary.sales
    else
      return 0
    end
  end

  def all_sales(month)
    month_salary = MonthSalary.find_by master_id: object.id, month_id: month.id

    if month_salary != nil
      return (month_salary.sales * 0.1).round
    else
      return 0
    end
  end

  def all_money(month)
    month_salary = MonthSalary.find_by master_id: object.id, month_id: month.id

    if month_salary != nil
      return month_salary.services
    else
      return 0
    end
  end

  def percent(money)
    return (money * 0.35).round
  end

  def percents(month)
    first_salary = first_salary(month)

    if first_salary != 0
      first_salary_with_percent_flag = percent(first_salary.last)

      all_master_money_in_month = first_salary.first

      sum = 0
      percent = "35"

      if all_master_money_in_month >= 150000
        sum = (all_master_money_in_month*0.45).round - first_salary_with_percent_flag
        percent = "45"
      elsif all_master_money_in_month >= 140000 && all_master_money_in_month < 150000
        sum = (all_master_money_in_month*0.44).round - first_salary_with_percent_flag
        percent = "44"
      elsif all_master_money_in_month >= 130000 && all_master_money_in_month < 140000
        sum = (all_master_money_in_month*0.43).round - first_salary_with_percent_flag
        percent = "43"
      elsif all_master_money_in_month >= 120000 && all_master_money_in_month < 130000
        sum = (all_master_money_in_month*0.42).round - first_salary_with_percent_flag
        percent = "42"
      elsif all_master_money_in_month >= 110000 && all_master_money_in_month < 120000
        sum = (all_master_money_in_month*0.41).round - first_salary_with_percent_flag
        percent = "41"
      elsif all_master_money_in_month >= 100000 && all_master_money_in_month < 110000
        sum = (all_master_money_in_month*0.4).round - first_salary_with_percent_flag
        percent = "40"
      elsif all_master_money_in_month >= 90000 && all_master_money_in_month < 100000
        percent = "39"
        sum = (all_master_money_in_month*0.39).round - first_salary_with_percent_flag
      elsif all_master_money_in_month >= 80000 && all_master_money_in_month < 90000
        percent = "38"
        sum = (all_master_money_in_month*0.38).round - first_salary_with_percent_flag
      elsif all_master_money_in_month >= 70000 && all_master_money_in_month < 80000
        percent = "37"
        sum = (all_master_money_in_month*0.37).round - first_salary_with_percent_flag
      elsif all_master_money_in_month >= 60000 && all_master_money_in_month < 70000
        percent = "36"
        sum = (all_master_money_in_month*0.36).round - first_salary_with_percent_flag
      elsif all_master_money_in_month < 60000
        sum = (all_master_money_in_month*0.35).round - first_salary_with_percent_flag
      end

      return percent, sum
    else
      return "35", 0
    end
  end
end
