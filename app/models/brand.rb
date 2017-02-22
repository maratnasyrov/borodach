class Brand < ActiveRecord::Base
  has_many :purchases
  has_many :shelves
  has_many :categories
end
