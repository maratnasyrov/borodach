class Master < ActiveRecord::Base
  has_many :work_days
  has_many :shelf_histories
  has_many :clients
  has_many :client_histories
  has_many :services
  
  scope :sort_by_id, -> { order('id ASC') }
end