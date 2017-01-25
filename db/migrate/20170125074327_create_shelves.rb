class CreateShelves < ActiveRecord::Migration
  def change
    create_table :shelves do |t|
      t.string :name
      t.integer :number
      t.integer :bulk
      t.references :purchase
      
      t.timestamps null: false
    end
  end
end
