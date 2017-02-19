class Shelf < ActiveRecord::Base
  has_many :record_shelves
  belongs_to :brands

  scope :sort_by_name, -> { order('name ASC') }
end
