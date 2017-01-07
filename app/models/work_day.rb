class WorkDay < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
  belongs_to :finances
  has_many :records, dependent: :destroy

  def create_records
    hour_start = 9

    time_start = Time.new()
    end_time = time_start.change(hour: hour_start+1)

    i = 1
    while i <= 11 do
      if hour_start == 12
        Record.create(
          client_name: "Обед",
          work_day_id: id,
          start_time: time_start.change(hour: hour_start + 3),
          end_time: time_start.change(hour: hour_start + 4),
          dinner: true
        )
      else
        Record.create(
          work_day_id: id,
          start_time: time_start.change(hour: hour_start + 3),
          end_time: time_start.change(hour: hour_start + 4)
        )
      end
      hour_start += 1
      time_start = time_start.change(hour: hour_start)
      i += 1
    end
  end
end
