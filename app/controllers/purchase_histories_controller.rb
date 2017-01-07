class PurchaseHistoriesController < ApplicationController
  expose(:purchase_histories)
  expose(:purchase)

  def create
    purchase_history = PurchaseHistory.create(purchase_history_params)
    success = purchase_history.save

    purchase = Purchase.find_by(id: params["purchase_id"])
    
    hash_params = params["purchase_history"]
    new_number = hash_params["number_changes"].to_i + purchase.number
    purchase.update_attributes(number: new_number)
    redirect_to purchases_path
  end

  private

  def purchase_history_params
    params.require(:purchase_history).permit(:price, :number_changes, :seller).merge(purchase_id: purchase.id)
  end
end
