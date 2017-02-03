class Master < ActiveRecord::Base
  has_many :work_days
  has_many :shelf_histories

  scope :sort_by_id, -> { order('id ASC') }
end