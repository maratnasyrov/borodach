class Order < ActiveRecord::Base
  has_many :product_lists

  scope :sort_by_date, -> { order('created_at DESC') }
end
