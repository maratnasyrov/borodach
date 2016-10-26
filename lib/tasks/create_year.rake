namespace :sync do
  task create_calendar: [:environment] do
    def update_calendar
      Year.last.nil? ? create_year : create_next_year

      create_months(Year.last)
    end

    def create_year
      year_number = Time.now.year

      year = Year.new(number: year_number)
      year.save
    end

    def create_next_year
      year_number = Year.last.number + 1

      year = Year.new(number: year_number)
      year.save
    end

    def create_months(year)
      name_of_the_months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December' 
      ]
      name_of_the_months.each do |month|
        month = Month.new(name_of_the_month: month, year_id: year.id)
        success = month.save

        create_days(month) if success
      end
    end

    def create_days(month)
      month_31 = [
         'January',
          'March',
          'May',
          'July',
          'August',
          'October',
          'December' 
      ]

      if 'February'.eql?(month.name_of_the_month)
        i = 1
        while i < 30
          day = Day.new(number_of_the_day: i, month_id: month.id)
          day.save
          i += 1
        end
      elsif !month_31.include?(month.name_of_the_month)
        i = 1
        while i < 31
          day = Day.new(number_of_the_day: i, month_id: month.id)
          day.save
          i += 1
        end
      elsif month_31.include?(month.name_of_the_month)
        i = 1
        while i < 32
          day = Day.new(number_of_the_day: i, month_id: month.id)
          day.save
          i += 1
        end
      end
    end

    update_calendar
  end
end