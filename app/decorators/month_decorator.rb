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

end
