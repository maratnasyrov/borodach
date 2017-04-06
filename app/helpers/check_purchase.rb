class CheckPurchase
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def check
    if object.number <= 1
      find_provider = Provider.find_by(id: Brand.find_by(id: object.brand_id).provider_id)
      last_order = Order.find_by provider_id: find_provider.id, closed_status: false
      number = 0

      if last_order.nil? || last_order.closed_status == true
        last_order = Order.create(name: "Заказ для #{find_provider.name}", status: true, closed_status: false, provider_id: find_provider.id)
      end

      if object.number <= 0
        number = object.need_number
      elsif object.number == 1
        number = object.need_number - 1
      end

      if last_order.status == true
        find_product_analog = ProductList.find_by name: object.name, order_id: last_order.id

        if find_product_analog.nil?
          ProductList.create(name: object.name, price: object.initial_cost, number: number, order_id: last_order.id, purchase_id: object.id, bulk: object.bulk)
        else
          find_product_analog.update_attributes(number: number)
        end
      end
    end
  end
end