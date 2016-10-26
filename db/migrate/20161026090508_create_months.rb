class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :name_of_the_month, null: false

      t.references :year
    end
  end
end
