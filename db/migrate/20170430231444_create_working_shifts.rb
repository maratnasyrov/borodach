class CreateWorkingShifts < ActiveRecord::Migration
  def change
    create_table :working_shifts do |t|
      t.integer :sales, default: 0
      t.integer :services, default: 0

      t.references :master
      t.references :day

      t.timestamps null: false
    end
  end
end
