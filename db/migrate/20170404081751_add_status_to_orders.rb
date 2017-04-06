class AddStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :boolean
    add_column :orders, :closed_status, :boolean
    add_column :orders, :invoice, :integer
  end
end
