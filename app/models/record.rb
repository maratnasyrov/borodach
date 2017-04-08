class Record < ActiveRecord::Base
  belongs_to :work_days
  has_many :record_services
  has_many :record_purchases
  has_many :record_shelves
  has_many :finances
  has_many :pre_records
  has_many :shelf_histories
  has_many :clients
  
  scope :all_records, -> { order('start_time ASC') }

  scope :first_four, -> (num) { order('start_time ASC').limit(num) }
  scope :second_four, -> (num) { (order('start_time ASC') - first_four(num)).first(4) }
  scope :third_four, -> (num) { (order('start_time ASC') - second_four(num) - first_four(num)).first(4)  }
end
