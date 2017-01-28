class CreateShelfHistories < ActiveRecord::Migration
  def change
    create_table :shelf_histories do |t|
      t.references :shelf
      t.references :master
      t.references :day
      t.integer :number_changes, null: false

      t.timestamps null: false
    end
  end
end
