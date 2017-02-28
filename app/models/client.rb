class Client < ActiveRecord::Base
  belongs_to :masters
  belongs_to :records
  has_many :client_histories
end
