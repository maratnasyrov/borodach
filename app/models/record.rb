class Record < ActiveRecord::Base
  belongs_to :work_days

  scope :all_records, -> { order('id ASC') }
end
