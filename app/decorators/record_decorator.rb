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
end
