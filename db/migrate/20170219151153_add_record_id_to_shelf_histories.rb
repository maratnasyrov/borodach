class AddRecordIdToShelfHistories < ActiveRecord::Migration
  def change
    add_column :shelf_histories, :record_id, :integer
  end
end
