class RecordShelf < ActiveRecord::Base
  belongs_to :records
  belongs_to :shelves
end
