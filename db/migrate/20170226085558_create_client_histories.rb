class CreateClientHistories < ActiveRecord::Migration
  def change
    create_table :client_histories do |t|
      t.references :client
      t.references :work_day
      t.references :day
      t.references :master
      t.references :record
      t.boolean :new_client, default: false

      t.timestamps null: false
    end
  end
end
