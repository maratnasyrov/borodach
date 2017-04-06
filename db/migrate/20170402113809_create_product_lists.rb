class CreateProductLists < ActiveRecord::Migration
  def change
    create_table :product_lists do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :number, null: false

      t.references :order

      t.timestamps null: false
    end
  end
end
