class BrandsController < ApplicationController
  expose(:brands) { Brand.all }
  expose(:brand, attributes: :brands_params)

  def create
    brand = Brand.create(brands_params)
    success = brand.save

    redirect_to brands_path if success
  end

  def destroy
    success = brand.destroy

    redirect_to brands_path if success
  end
  
  private

  def brands_params
    params.require(:brand).permit(:name)
  end
end
