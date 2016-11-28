class WorkDay < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
  has_many :records, dependent: :destroy

  def create_records
    i = 1
    hour_start = 9
    minute_start = 0
    while i <= 11 do
      time_start = "#{hour_start}:#{minute_start}0"
      time_end = "#{hour_start+1}:#{minute_start}0"
      if hour_start == 12
        Record.create(client_name: "Обед", work_day_id: id, time_start: time_start, time_end: time_end, dinner: true)
      else
        Record.create(work_day_id: id, time_start: time_start, time_end: time_end)
      end
      hour_start += 1
      i += 1
    end
  end
end
