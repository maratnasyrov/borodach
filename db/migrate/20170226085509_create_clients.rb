class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.integer :number, null: false, default: 0
      t.references :record
      t.references :master

      t.timestamps null: false
    end
  end
end
