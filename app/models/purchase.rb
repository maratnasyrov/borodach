class Purchase < ActiveRecord::Base
  has_many :record_purchases
  has_many :purchase_history, dependent: :destroy
  belongs_to :categories
  belongs_to :brands

  scope :sort_by_name, -> { order('name ASC') }
  scope :for_sale, -> { where(not_for_sale: false) }
end
