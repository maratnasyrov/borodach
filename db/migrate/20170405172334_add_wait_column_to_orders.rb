class AddWaitColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :wait, :boolean
  end
end
