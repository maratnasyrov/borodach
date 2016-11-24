class WorkDay < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
end
