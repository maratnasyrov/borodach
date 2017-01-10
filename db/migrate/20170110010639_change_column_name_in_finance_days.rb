class ChangeColumnNameInFinanceDays < ActiveRecord::Migration
  def change
    rename_column :finance_days, :months_id, :month_id
    rename_column :finance_days, :days_id, :day_id
  end
end
