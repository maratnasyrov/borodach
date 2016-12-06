class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.integer :price, null:false
      t.string :time, null: false

      t.timestamps null: false
    end
  end
end
