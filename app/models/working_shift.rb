class WorkingShift < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
  has_many :finances
end
