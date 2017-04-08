class AddAvatarToMaster < ActiveRecord::Migration
  def up
    add_attachment :masters, :avatar
  end

  def down
    remove_attachment :masters, :avatar
  end
end
