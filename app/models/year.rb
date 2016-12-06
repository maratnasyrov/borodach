class Year < ActiveRecord::Base
  has_many :months

  scope :year_search, -> (num) { where(id: num) }
end
