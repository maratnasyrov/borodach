class AddMasterIdToService < ActiveRecord::Migration
  def change
    add_column :services, :master_id, :integer
  end
end
