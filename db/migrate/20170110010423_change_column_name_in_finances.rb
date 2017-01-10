class ChangeColumnNameInFinances < ActiveRecord::Migration
  def change
    rename_column :finances, :masters_id, :master_id
    rename_column :finances, :days_id, :day_id
  end
end
