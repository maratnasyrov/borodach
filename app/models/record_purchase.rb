class RecordPurchase < ActiveRecord::Base
  belongs_to :purchases
  belongs_to :records
end
