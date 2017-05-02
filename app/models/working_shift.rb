class WorkingShift < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
  belongs_to :month_salaries
  has_many :finances
end
