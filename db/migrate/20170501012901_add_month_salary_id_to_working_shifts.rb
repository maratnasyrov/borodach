class AddMonthSalaryIdToWorkingShifts < ActiveRecord::Migration
  def change
    add_column :working_shifts, :month_salary_id, :integer
  end
end
