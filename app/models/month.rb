class Month < ActiveRecord::Base
  has_many :days
  belongs_to :years

  scope :all_month_in_year, -> { where(year_id: Year.find_by(number: Date.today.year)) }
end
