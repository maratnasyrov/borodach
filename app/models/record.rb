class Record < ActiveRecord::Base
  belongs_to :work_days
  has_many :record_services
  has_many :record_purchases
  has_many :record_shelves
  has_many :finances
  has_many :pre_records
  has_many :shelf_histories
  
  scope :all_records, -> { order('start_time ASC') }
end
