class AddPersonalDataToMasters < ActiveRecord::Migration
  def change
    add_column :masters, :user_id, :integer
    add_column :masters, :phone, :string, limit: 11
    add_column :masters, :email, :string
    add_column :masters, :birthday, :date
    add_column :masters, :about_master, :string
    add_column :masters, :master_active, :boolean
    add_column :masters, :online_record, :boolean
  end
end
