class CreateRecordServices < ActiveRecord::Migration
  def change
    create_table :record_services do |t|
      t.references :record
      t.references :service

      t.timestamps null: false
    end
  end
end
