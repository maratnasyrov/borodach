class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.references :master
      t.references :day

      t.timestamps null: false
    end
  end
end
