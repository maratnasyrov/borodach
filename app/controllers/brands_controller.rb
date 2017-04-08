class BrandsController < ApplicationController
  expose(:provider)

  expose(:brands) { Brand.all }
  expose(:brand, attributes: :brands_params)
  expose(:purchase_history) { PurchaseHistory.new() }
  expose(:purchase) { Purchase.new() }

  expose(:category) { Category.new() }

  def create
    brand = Brand.create(brands_params)
    success = brand.save

    provider = Provider.find_by id: brand.provider_id

    redirect_to provider_path(provider)
  end

  def update
    success = brand.update(brands_params)

    provider = Provider.find_by id: brand.provider_id

    redirect_to provider_path(provider) if success
  end

  def destroy
    purchase_empty = brand.purchases.empty?
    category_empty = brand.categories.empty?
    success = brand.destroy if purchase_empty && category_empty

    provider = Provider.find_by id: brand.provider_id

    if success
      redirect_to provider_path(provider)
    else
      redirect_to provider_path(provider), notice: "Удаление невозможно, так как есть товары или категории данного бренда!"
    end
  end
  
  private

  def brands_params
    params.require(:brand).permit(:name, :image).merge(provider_id: provider.id)
  end
end
