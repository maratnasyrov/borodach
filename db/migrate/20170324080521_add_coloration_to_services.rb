class AddColorationToServices < ActiveRecord::Migration
  def change
    add_column :services, :coloration, :boolean
  end
end
