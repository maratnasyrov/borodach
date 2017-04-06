class AddProviderIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :provider_id, :integer
  end
end
