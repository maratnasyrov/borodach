class AddNumberOfTheMonths < ActiveRecord::Migration
  def change
    add_column :months, :number, :integer
  end
end
