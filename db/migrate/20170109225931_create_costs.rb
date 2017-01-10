class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
