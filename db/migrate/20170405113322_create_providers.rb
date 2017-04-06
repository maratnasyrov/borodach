class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :contact_name
      
      t.timestamps null: false
    end
  end
end
