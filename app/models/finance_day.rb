class FinanceDay < ActiveRecord::Base
  belongs_to :days
  has_many :finances
end
