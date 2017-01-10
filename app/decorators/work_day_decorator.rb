class WorkDayDecorator < ApplicationDecorator
  delegate_all

  def show_work_day_price
    sum = 0
    object.records.all.each do |record|
      record.finances.all.each do |finance|
        sum += finance.price
      end
    end

    "#{sum}"
  end
end
