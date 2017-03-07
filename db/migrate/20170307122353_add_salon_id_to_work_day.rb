class AddSalonIdToWorkDay < ActiveRecord::Migration
  def change
    add_column :work_days, :salon_id, :integer
  end
end
