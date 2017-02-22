class BrandsController < ApplicationController
  expose(:brands) { Brand.all }
  expose(:brand, attributes: :brands_params)

  expose(:category) { Category.new() }

  def create
    brand = Brand.create(brands_params)
    success = brand.save

    redirect_to brands_path if success
  end

  def destroy
    purchase_empty = brand.purchases.empty?
    category_empty = brand.categories.empty?
    brand.destroy if purchase_empty && category_empty

    redirect_to brands_path
  end
  
  private

  def brands_params
    params.require(:brand).permit(:name)
  end
end
