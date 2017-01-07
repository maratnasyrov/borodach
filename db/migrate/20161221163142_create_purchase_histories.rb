class CreatePurchaseHistories < ActiveRecord::Migration
  def change
    create_table :purchase_histories do |t|
      t.references :purchase
      t.integer :number_changes, null: false
      t.integer :price, null: false
      t.string :seller

      t.timestamps null: false
    end
  end
end
