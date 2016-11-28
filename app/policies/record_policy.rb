class RecordPolicy
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def set_check?(check)
    check == true ? true : false
  end

  def set_status_class
    if set_check?(record.client_added) && !set_check?(record.closed_record)
      'client-added'
    elsif set_check?(record.dinner)
      'dinner'
    elsif set_check?(record.closed_record)
      'closed-record'
    end
  end

  def status_closed?
    record.closed_record == true ? false : true
  end 
end
