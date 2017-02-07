class AddNotShowRecordToRecords < ActiveRecord::Migration
  def change
    add_column :records, :not_show, :boolean, default: false
  end
end
