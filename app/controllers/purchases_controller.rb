class PurchasesController < ApplicationController
  expose(:purchases) { Purchase.all }
  expose(:purchase)
  expose(:purchase_history)
  expose(:brands) { Brand.all }
  expose(:brand)
  
  def create
    success = Purchase.create(purchases_params)

    redirect_to brand_path(brand) if success
  end

  def update
    flag_number = purchase.number
    success = purchase.update(purchases_params)
    redirect_to brand_path(brand) if success
  end
  
  def destroy
    purchase.destroy
    redirect_to brand_path(brand) if success
  end

  private

  def purchases_params
    params.require(:purchase).permit(:name, :price, :number, :bulk, :initial_cost, :brand_id, :not_for_sale, :category_id).merge(brand_id: brand.id)
  end
end
