class CreatePreRecords < ActiveRecord::Migration
  def change
    create_table :pre_records do |t|
      t.references :day
      t.references :record
      t.string :client_name
      t.string :client_phone
      t.integer :master_id
      t.string :after 

      t.timestamps null: false
    end
  end
end
