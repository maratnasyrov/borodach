class Category < ActiveRecord::Base
  has_many :purchases
  belongs_to :brands
end
