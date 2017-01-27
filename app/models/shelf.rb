class Shelf < ActiveRecord::Base
  has_many :record_shelves
end
