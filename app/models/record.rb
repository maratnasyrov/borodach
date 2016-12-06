class Record < ActiveRecord::Base
  belongs_to :work_days
  has_many :record_services
  
  scope :all_records, -> { order('start_time ASC') }
end
