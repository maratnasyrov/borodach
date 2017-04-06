class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :closed_date, :date
  end
end
