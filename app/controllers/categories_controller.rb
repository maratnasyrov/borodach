class CategoriesController < ApplicationController
  expose(:brand)
  expose(:categories) { Category.all }
  expose(:category, attributes: :categories_params)

  def create
    category = Category.create(categories_params)
    success = category.save

    redirect_to brands_path if success
  end

  def destroy
    purchase_empty = category.purchases.empty?
    category.destroy if purchase_empty

    redirect_to brands_path
  end
  
  private

  def categories_params
    params.require(:category).permit(:name, :not_for_sale).merge(brand_id: brand.id)
  end
end
