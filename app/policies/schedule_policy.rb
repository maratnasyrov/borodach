class SchedulePolicy
  attr_reader :master_id, :day_id

  def initialize(master_id, day_id)
    @master_id = master_id
    @day_id = day_id
  end

  def create?
    search = WorkDay.find_by(master_id: master_id, day_id: day_id)
    search.nil? ? true : false
  end
end
