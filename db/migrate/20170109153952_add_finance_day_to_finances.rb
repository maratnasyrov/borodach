class AddFinanceDayToFinances < ActiveRecord::Migration
  def change
    add_column :finances, :finance_day_id, :integer
  end
end
