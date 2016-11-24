class Day < ActiveRecord::Base
  belongs_to :months
  has_many :work_days
end
