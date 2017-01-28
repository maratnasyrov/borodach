class WorkDayPolicy
  attr_reader :work_day

  def initialize(work_day)
    @work_day = work_day
  end

  def smth_records_added?
    bool = true
    
    work_day.records.all.each do |record|
      if !record.client_added?
        bool = true
      else
        bool = false
        
        break
      end
    end

    return bool
  end
end