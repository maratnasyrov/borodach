class AddBrandIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :brand_id, :integer, default: false
  end
end
