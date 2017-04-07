class AddDefaultValueToPurchases < ActiveRecord::Migration
  def change
    change_column :purchases, :number, :integer, default: 0
  end
end
