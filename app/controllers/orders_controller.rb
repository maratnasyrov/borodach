class OrdersController < ApplicationController
  expose(:orders) { Order.all }
  expose(:order)
  expose(:product_lists) { order.product_lists.all }

  def create
    success = Order.create(orders_params)
    redirect_to orders_path if success
  end

  def update
    success = order.update(orders_params)
    redirect_to orders_path if success
  end
  
  def destroy
    order.destroy
    redirect_to orders_path
  end

  def close
    set_closed_status
  end

  private

  def orders_params
    params.require(:order).permit(:name, :invoice)
  end

  def set_closed_status
    status = true

    product_lists.each do |product|
      if product.closed_status == false
        status = false

        break
      end
    end

    if status
      order.update_attributes(closed_status: true, closed_date: DateTime.now)

      redirect_to orders_path
    else
      redirect_to order_path(order), notice: 'Не все товары получили статус "Добавлено на склад"!'
    end
  end
end
