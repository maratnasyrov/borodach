class MonthSalary < ActiveRecord::Base
  belongs_to :months
  belongs_to :masters
  has_many :working_shifts
end
