class PurchaseHistory < ActiveRecord::Base
  belongs_to :purchase

  scope :sort_by_date, -> { order('created_at DESC') }
end
