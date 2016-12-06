class Month < ActiveRecord::Base
  has_many :days
  belongs_to :years

  scope :year_detect, -> (num) { where(year_id: Year.find_by(id: num)) }
end
