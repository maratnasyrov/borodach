class AddStatusToProductLists < ActiveRecord::Migration
  def change
    add_column :product_lists, :closed_status, :boolean, default: false
  end
end
