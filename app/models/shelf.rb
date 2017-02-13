class Shelf < ActiveRecord::Base
  has_many :record_shelves
  belongs_to :brands
end
