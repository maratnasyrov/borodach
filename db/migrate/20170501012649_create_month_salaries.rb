class CreateMonthSalaries < ActiveRecord::Migration
  def change
    create_table :month_salaries do |t|
      t.integer :sales, default: 0
      t.integer :services, default: 0

      t.references :master
      t.references :month

      t.timestamps null: false
    end
  end
end
