class Brand < ActiveRecord::Base
  has_many :purchases
  has_many :shelves
end
