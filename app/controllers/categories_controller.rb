class CategoriesController < ApplicationController
  expose(:brand)
  expose(:categories) { Category.all }
  expose(:category, attributes: :categories_params)

  def create
    category = Category.create(categories_params)
    success = category.save

    provider = Provider.find_by id: brand.provider_id

    redirect_to provider_path(provider) if success
  end

  def destroy
    purchase_empty = category.purchases.empty?
    success = category.destroy if purchase_empty

    provider = Provider.find_by id: brand.provider_id

    if success
      redirect_to provider_path(provider) 
    else
      redirect_to provider_path(provider), notice: "Удаление невозможно, так как существует товар данной категории!"
    end
  end
  
  private

  def categories_params
    params.require(:category).permit(:name, :not_for_sale).merge(brand_id: brand.id)
  end
end
