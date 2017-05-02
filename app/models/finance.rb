class Finance < ActiveRecord::Base
  belongs_to :masters
  belongs_to :days
  belongs_to :finance_days
  belongs_to :records
  belongs_to :costs
  belongs_to :working_shifts

  scope :consumption, -> { where(finance_type: false) }
  scope :coming, -> { where(finance_type: true) }
end
