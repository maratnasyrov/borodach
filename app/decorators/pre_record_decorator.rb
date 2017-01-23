class PreRecordDecorator < ApplicationDecorator
  delegate_all

  def info
    "#{object.client_name}, #{object.client_phone}"
  end

  def detailed_info
    "Запись: #{object.record_id}, Мастер: #{Master.find_by(id: object.master_id).name}"
  end
end
