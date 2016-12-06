class Record < ActiveRecord::Base
  belongs_to :work_days
  has_many :record_services
  
  scope :all_records, -> { order('id ASC') }
end
