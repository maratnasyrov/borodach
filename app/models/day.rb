class Day < ActiveRecord::Base
  belongs_to :months
  has_many :work_days
  has_many :finances
  has_many :finance_days
  has_many :pre_records
  has_many :shelf_histories
  has_many :working_shifts
  
  def find_master(master_id)
    Master.all.find_by(id: master_id).decorate.master_info
  end
end
