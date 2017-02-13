class ShelfHistory < ActiveRecord::Base
  belongs_to :shelf
  belongs_to :day
  belongs_to :master

  scope :sort_by_date, -> { order('created_at DESC') }
  scope :find_day, -> (day_id) { where(day_id: day_id) }
end
