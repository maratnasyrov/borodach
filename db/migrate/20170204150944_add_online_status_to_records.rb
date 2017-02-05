class AddOnlineStatusToRecords < ActiveRecord::Migration
  def change
    add_column :records, :online, :boolean
  end
end
