class ServiceDecorator < ApplicationDecorator
  delegate_all

  def service_info
    "#{object.name}"
  end
end
