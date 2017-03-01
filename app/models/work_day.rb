class WorkDay < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
  belongs_to :finances
  has_many :records, dependent: :destroy
  has_many :client_histories

  scope :masters_work_days, -> (master) { where(master_id: master.id) }

  def create_records(master)
    user = User.find_by id: master.user_id
    hour_start = 0
    hour_end = 0

    if UserPolicy.new(user).director?
      hour_start = 8
      hour_end = 12
    else
      hour_start = 9
      hour_end = 11
    end

    time_start = Time.new()
    end_time = time_start.change(hour: hour_start+1)

    i = 1
    while i <= hour_end do
      if hour_start == 12
        Record.create(
          client_name: "Обед",
          work_day_id: id,
          start_time: time_start.change(hour: hour_start ),
          end_time: time_start.change(hour: hour_start + 1),
          dinner: true,
          not_show: true
        )
      else
        Record.create(
          work_day_id: id,
          start_time: time_start.change(hour: hour_start),
          end_time: time_start.change(hour: hour_start + 1)
        )
      end
      hour_start += 1
      time_start = time_start.change(hour: hour_start)
      i += 1
    end
  end
end
