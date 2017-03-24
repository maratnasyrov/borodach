class RecordPolicy
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def set_check?(check)
    check == true ? true : false
  end

  def set_status_class
    set_class = ""
    if set_check?(record.client_added) && !set_check?(record.closed_record)
      set_class = 'client-added'
    elsif set_check?(record.dinner)
      set_class = 'dinner'
    elsif set_check?(record.closed_record)
       set_class = 'closed-record'
    end

    if record.record_id.nil?
      return set_class
    else
      return set_class + ' depend'
    end
  end

  def check_status?
    if status_closed? == false
      false
    elsif status_added? == true
      true
    else
      false
    end
  end


  def status_closed?
    record.closed_record == true ? false : true
  end

  def status_added?
    record.client_added == true ? true : false
  end
end
