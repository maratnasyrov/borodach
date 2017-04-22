class ProductListsController < ApplicationController
  expose(:product_lists) { ProductList.all }
  expose(:product_list)
  expose(:order)

  def create
    success = ProductList.create(product_lists_params)
    redirect_to order_path(order) if success
  end

  def update
    success = product_list.update(product_lists_params)
    redirect_to order_path(order) if success
  end
  
  def destroy
    product_list.destroy
    redirect_to order_path(order)
  end

  def add_to_stock
    purchase = Purchase.find_by id: product_list.purchase_id

    add_purchase(purchase)
  end

  private

  def add_purchase(purchase)
    success = purchase.update_attributes(number: product_list.number)
    write_history = PurchaseHistory.create(price: product_list.price, number_changes: product_list.number, seller: current_user.full_name, purchase_id: purchase.id) if success

    update = product_list.update_attributes(closed_status: true) if write_history

    order = Order.find_by id: product_list.order_id

    redirect_to order_path(order) if update
  end

  def product_lists_params
    params.require(:product_list).permit(:name, :price, :number)
  end
end
