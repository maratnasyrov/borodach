class ShelvesController < ApplicationController
  expose(:shelves) { Shelf.all }
  expose(:shelf)

  def create
    find_purchase = Purchase.all.find_by(id: shelf_params["purchase_id"].to_i)
    
    if find_purchase.number != 0
      flag_purchase_number = find_purchase.number
      params["shelf"]["name"] = find_purchase.name
      params["shelf"]["bulk"] = find_purchase.bulk * params["shelf"]["number"].to_i

      shelf = Shelf.create(shelf_params) if find_purchase
      success = shelf.save

      succes_number_change = find_purchase.update_attributes(number: find_purchase.number - shelf.number) if success
      if find_purchase.number - flag_purchase_number != 0
        PurchaseHistory.create(
          purchase_id: find_purchase.id,
          number_changes: find_purchase.number - flag_purchase_number,
          price: find_purchase.initial_cost,
          seller: current_user.full_name
        )   
      end

      redirect_to shelves_path if succes_number_change
    else
      redirect_to shelves_path
    end
  end

  private

  def shelf_params
    params.require(:shelf).permit(:name, :bulk, :number, :purchase_id)
  end
end
