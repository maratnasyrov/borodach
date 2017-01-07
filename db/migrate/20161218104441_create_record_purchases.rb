class CreateRecordPurchases < ActiveRecord::Migration
  def change
    create_table :record_purchases do |t|
      t.references :record
      t.references :purchase

      t.timestamps null: false
    end
  end
end
