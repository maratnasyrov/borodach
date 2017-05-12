class CreateLandingImages < ActiveRecord::Migration
  def change
    create_table :landing_images do |t|

      t.timestamps null: false
    end
  end
end
