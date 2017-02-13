class AddBrandIdToShelves < ActiveRecord::Migration
  def change
    add_column :shelves, :brand_id, :integer, default: false
  end
end
