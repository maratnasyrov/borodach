class AddDepenceRecordsForRecords < ActiveRecord::Migration
  def change
    add_column :records, :record_id, :integer
  end
end
