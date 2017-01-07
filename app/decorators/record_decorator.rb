class RecordDecorator < ApplicationDecorator
  delegate_all

  def client_info
    client_name_check = !object.client_name.eql?('') && !object.client_name.nil?
    client_phone_check = !object.client_phone.eql?('') && !object.client_phone.nil?
    
    if client_phone_check && client_name_check
      "#{object.client_name}, #{object.client_phone}"
    elsif client_name_check
      "#{object.client_name}"
    elsif client_phone_check
      "#{object.client_phone}"
    end
  end

  def record_number
    "Record number: #{object.id}"
  end

  def record_services_price
    price = 0
    
    object.record_services.all.each do |record_service|
      service = Service.all.find_by(id: record_service.service_id)
      price += service.price
    end

    "Price: #{price}"
  end

  def record_purchases_price
    price = 0
    
    object.record_purchases.all.each do |record_purchase|
      purchase = Purchase.all.find_by(id: record_purchase.purchase_id)
      price += purchase.price
    end

    "Price: #{price}"
  end
end
