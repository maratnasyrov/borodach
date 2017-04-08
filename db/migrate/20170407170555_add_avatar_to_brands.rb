class AddAvatarToBrands < ActiveRecord::Migration
  def up
    add_attachment :brands, :image
  end

  def down
    remove_attachment :brands, :image
  end
end
