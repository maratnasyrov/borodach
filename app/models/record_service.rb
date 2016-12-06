class RecordService < ActiveRecord::Base
  belongs_to :services
  belongs_to :records
end
