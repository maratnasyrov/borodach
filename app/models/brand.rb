class Brand < ActiveRecord::Base
  has_many :purchases
  has_many :shelves
  has_many :categories

  belongs_to :providers
end
