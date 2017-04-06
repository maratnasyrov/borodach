class PurchaseHistoriesController < ApplicationController
  expose(:purchase_histories)
  expose(:purchase)

  def create
    purchase_history = PurchaseHistory.create(purchase_history_params)
    success = purchase_history.save

    purchase = Purchase.find_by(id: params["purchase_id"])
    
    hash_params = params["purchase_history"]
    if purchase.number.nil?
      new_number = hash_params["number_changes"].to_i 
    else
      new_number = hash_params["number_changes"].to_i + purchase.number
    end
    purchase.update_attributes(number: new_number)

    brand = Brand.find_by id: purchase.brand_id
    redirect_to brand_path(brand)
  end

  private

  def purchase_history_params
    params.require(:purchase_history).permit(:price, :number_changes, :seller).merge(purchase_id: purchase.id)
  end
end
