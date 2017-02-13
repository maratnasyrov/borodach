class PurchasesController < ApplicationController
  expose(:purchases) { Purchase.all }
  expose(:purchase)
  expose(:purchase_history)
  expose(:brands) { Brand.all }

  def create
    success = Purchase.create(purchases_params)
    respond_with purchase if success
  end

  def update
    flag_number = purchase.number
    success = purchase.update(purchases_params)
    redirect_to purchases_path if success
  end
  
  def destroy
    purchase.destroy
    redirect_to purchases_path
  end

  private

  def purchases_params
    params.require(:purchase).permit(:name, :price, :number, :bulk, :initial_cost, :brand_id)
  end
end
