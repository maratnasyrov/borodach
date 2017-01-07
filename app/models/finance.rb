class Finance < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
  belongs_to :finance_days
end
