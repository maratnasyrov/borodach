class Purchase < ActiveRecord::Base
  has_many :record_purchases
  has_many :purchase_history, dependent: :destroy

  scope :sort_by_name, -> { order('name ASC') }
end
