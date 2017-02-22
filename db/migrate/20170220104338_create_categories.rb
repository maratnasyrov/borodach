class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.boolean :not_for_sale, null: false, default: false
      
      t.references :brand

      t.timestamps null: false
    end
  end
end
