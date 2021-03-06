class ShelvesController < ApplicationController
  expose(:brands) { Brand.all }
  expose(:shelves) { Shelf.all }
  expose(:shelf, attributes: :shelf_params)
  expose(:year) { Year.find_by number: Date.today.year }
  expose(:month) { Month.find_by name_of_the_month: Date::MONTHNAMES[Date.today.month], year_id: year.id }
  expose(:day) { Day.find_by number_of_the_day: Date.today.mday, month_id: month.id  }

  def create
    find_purchase = Purchase.all.find_by(id: shelf_params["purchase_id"].to_i)
    find_shelf = Shelf.all.find_by(name: find_purchase.name) if !find_purchase.nil?

    if find_purchase.number != 0 && !find_purchase.number.eql?(nil) && find_purchase.number > 0 && find_shelf.nil?
      flag_purchase_number = find_purchase.number
      params["shelf"]["name"] = find_purchase.name
      params["shelf"]["bulk"] = find_purchase.bulk * params["shelf"]["number"].to_i
      params["shelf"]["brand_id"] = find_purchase.brand_id

      shelf = Shelf.create(shelf_params) if find_purchase
      success = shelf.save

      succes_number_change = find_purchase.update_attributes(number: find_purchase.number - shelf.number) if success

      CheckPurchase.new(find_purchase).check
      
      if find_purchase.number - flag_purchase_number != 0
        PurchaseHistory.create(
          purchase_id: find_purchase.id,
          number_changes: find_purchase.number - flag_purchase_number,
          price: find_purchase.initial_cost,
          seller: current_user.full_name
        )   
      end

      redirect_to shelves_path if succes_number_change
    elsif find_purchase.number < 0 || find_purchase.number == 0 || find_purchase.number.nil?
      redirect_to shelves_path, notice: "Товар отсутствует на складе или уже был добавлен!"
    end
  end

  def add_shelf
    find_purchase = Purchase.all.find_by(id: shelf.purchase_id)

    if find_purchase.number != 0 && !find_purchase.number.eql?(nil) && find_purchase.number > 0
      flag_purchase_number = find_purchase.number

      shelf.update_attributes(number: shelf.number + 1, bulk: shelf.bulk + find_purchase.bulk) if find_purchase
      success = shelf.save

      succes_number_change = find_purchase.update_attributes(number: find_purchase.number - 1) if success

      CheckPurchase.new(find_purchase).check

      if find_purchase.number - flag_purchase_number != 0
        PurchaseHistory.create(
          purchase_id: find_purchase.id,
          number_changes: find_purchase.number - flag_purchase_number,
          price: find_purchase.initial_cost,
          seller: current_user.full_name
        )   
      end

      redirect_to shelves_path if succes_number_change
    elsif find_purchase.number < 0 || find_purchase.number == 0 || find_purchase.number.nil?
      redirect_to shelves_path, notice: "Товар отсутствует на складе!"
    end
  end

  def destroy
    if shelf.bulk <= 0
      success = shelf.destroy

      redirect_to shelves_path if success
    else
      redirect_to shelves_path, notice: "Товар не закончился!"
    end
  end

  def update
    success = shelf.update(shelf_params)
    redirect_to shelves_path if success
  end

  private

  def shelf_params
    params.require(:shelf).permit(:name, :bulk, :number, :purchase_id, :brand_id)
  end
end
