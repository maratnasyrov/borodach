class AddNotForSaleToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :not_for_sale, :boolean, default: false
  end
end
