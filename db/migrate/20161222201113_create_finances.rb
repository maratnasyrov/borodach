class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.references :masters
      t.references :days
      t.boolean :cash_type, null: false, default: false
      t.integer :price, null: false
      t.string :comment
      t.string :client_name
      t.string :client_phone
      t.boolean :service_type, null:false
      t.integer :service_id, null: false
      t.boolean :finance_type, null:  false, default: false

      t.timestamps null: false
    end
  end
end
