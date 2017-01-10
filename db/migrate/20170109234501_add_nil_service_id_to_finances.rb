class AddNilServiceIdToFinances < ActiveRecord::Migration
  def change
    change_column :finances, :service_id, :integer, null: true
  end
end
