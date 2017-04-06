class AddColumnsToProductLists < ActiveRecord::Migration
  def change
    add_column :product_lists, :purchase_id, :integer
    add_column :product_lists, :bulk, :integer
  end
end
