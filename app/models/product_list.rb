class ProductList < ActiveRecord::Base
  belongs_to :orders
end
