class AddWorkingShiftIdToFinances < ActiveRecord::Migration
  def change
    add_column :finances, :working_shift_id, :integer
  end
end
