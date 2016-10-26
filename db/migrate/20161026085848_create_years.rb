class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.integer :number, null: false, foreign_key: true
    end
  end
end
