class ShelfHistory < ActiveRecord::Base
  belongs_to :shelf
  belongs_to :day
  belongs_to :master

  scope :sort_by_date, -> { order('created_at DESC') }
end
