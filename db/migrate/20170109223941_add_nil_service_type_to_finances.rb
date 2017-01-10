class AddNilServiceTypeToFinances < ActiveRecord::Migration
  def change
    change_column :finances, :service_type, :boolean, null: true
  end
end
