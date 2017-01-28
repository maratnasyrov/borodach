class Master < ActiveRecord::Base
  has_many :work_days
  has_many :shelf_histories
end