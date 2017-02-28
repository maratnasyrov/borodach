class ClientHistory < ActiveRecord::Base
  belongs_to :clients
  belongs_to :masters
  belongs_to :records
  belongs_to :work_day
end
