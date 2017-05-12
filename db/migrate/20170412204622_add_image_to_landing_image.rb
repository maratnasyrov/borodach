class AddImageToLandingImage < ActiveRecord::Migration
  def up
    add_attachment :landing_images, :image
  end

  def down
    remove_attachment :landing_images, :image
  end
end
