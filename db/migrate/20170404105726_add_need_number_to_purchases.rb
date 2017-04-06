class AddNeedNumberToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :need_number, :integer, default: 2
  end
end
