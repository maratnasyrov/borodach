class FinanceDay < ActiveRecord::Base
  belongs_to :days
  belongs_to :months
  has_many :finances
end
