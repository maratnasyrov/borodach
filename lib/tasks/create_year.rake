namespace :create_year do
  task create_calendar: [:environment] do
    def update_calendar
      Year.last.nil? ? create_year(Time.now.year) : create_year(Year.last.number + 1)
      Cost.create(name: "Другое") if Cost.all.empty?
    end

    def create_year(year_number)
      year = Year.new(number: year_number)
      year.save

      create_months(Year.last)
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
      i = 1
      name_of_the_months.each do |month|
        month = Month.new(name_of_the_month: month, year_id: year.id, number: i)
        success = month.save

        create_days(month, year.number) if success
        i += 1
      end
    end

    def create_days(month ,year_number)
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
        Date.leap?(year_number) ? create_days_number(month, 30) : create_days_number(month, 29)    
      elsif !month_31.include?(month.name_of_the_month)
        create_days_number(month, 31)
      elsif month_31.include?(month.name_of_the_month)
        create_days_number(month, 32)
      end
    end

    def create_days_number(month, n)
      i = 1
      while i < n
        day = Day.new(number_of_the_day: i, month_id: month.id)
        day.save
        i += 1
      end
    end

    update_calendar
  end
end