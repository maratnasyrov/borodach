class CreateFinanceDays < ActiveRecord::Migration
  def change
    create_table :finance_days do |t|

      t.timestamps null: false
    end
  end
end
