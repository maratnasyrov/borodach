class CreateRecordShelves < ActiveRecord::Migration
  def change
    create_table :record_shelves do |t|
      t.references :record
      t.references :shelf
      t.references :day
      t.integer :number, default: 0

      t.timestamps null: false
    end
  end
end
