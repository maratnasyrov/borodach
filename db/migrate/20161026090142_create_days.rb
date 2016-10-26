class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :number_of_the_day, null: false

      t.references :month
    end
  end
end
