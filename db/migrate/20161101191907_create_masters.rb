class CreateMasters < ActiveRecord::Migration
  def change
    create_table :masters do |t|
      t.string :name, null: false, default: ""
      t.string :last_name, null: false, default: ""

      t.timestamps
    end
  end
end
