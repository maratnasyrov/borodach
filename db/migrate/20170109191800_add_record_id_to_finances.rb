class AddRecordIdToFinances < ActiveRecord::Migration
  def change
    add_column :finances, :record_id, :integer
  end
end
