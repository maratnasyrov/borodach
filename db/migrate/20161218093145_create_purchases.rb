class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name, null: false
      t.integer :price, null:false
      t.integer :number
      t.integer :initial_cost
      t.integer :bulk, null: false

      t.timestamps null: false
    end
  end
end
