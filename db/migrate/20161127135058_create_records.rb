class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :client_name
      t.string :client_phone
      t.string :payment_method
      t.time :start_time
      t.time :end_time
      t.string :comment
      t.integer :discount
      t.integer :price
      t.boolean :dinner, null: false, default: "false"
      t.boolean :client_added, null: false, default: "false"
      t.boolean :closed_record, null: false, default: "false"

      t.references :work_day

      t.timestamps null: false
    end
  end
end
