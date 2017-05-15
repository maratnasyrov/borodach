class AddSalonIdToFinances < ActiveRecord::Migration
  def change
    add_column :finances, :salon_id, :integer
  end
end
