  class RecordServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :destroy]

  expose(:record)
  expose(:master)
  expose(:record_services) { record.record_services  }
  expose(:record_service, attributes: :record_services_params) 

  def create
    record_service = RecordService.create(record_services_params)
    service = Service.find_by id: record_service.service_id
    notice = nil

    if service.coloration.eql?(true)
      if service.name.eql?("Окрашивание (средние волосы)")
        record_next = Record.find_by id: record.id + 1

        if record_next.nil?
          notice = "Невозможно добавить окрашивание на это время, так как данная услуга займет больше одного часа по времени! Пожалуйста, выберите другое время."
        elsif record_next.client_added == false && record_next.dinner == false
          record.update_attributes(end_time: record_next.end_time)
          record_next.update_attributes(client_name: service.name, client_added: true, record_id: record.id)
        else
          notice = "Невозможно добавить окрашивание на это время, так как данная услуга займет больше одного часа по времени! А следующий час занят! Пожалуйста, выберите другое время."
        end
      elsif service.name.eql?("Окрашивание (длинные волосы)")
        record_next_one = Record.find_by id: record.id + 1
        record_next_two = Record.find_by id: record.id + 2

        if record_next_one.nil? || record_next_two.nil?
          notice = "Невозможно добавить окрашивание на это время, так как данная услуга займет около 2 часов! Пожалуйста, выберите другое время."
        elsif record_next_one.client_added == false && record_next_two.client_added == false && record_next_one.dinner == false && record_next_two.dinner == false
          record.update_attributes(end_time: record_next_two.end_time)
          record_next_one.update_attributes(client_name: service.name, client_added: true, record_id: record.id)
          record_next_two.update_attributes(client_name: service.name, client_added: true, record_id: record.id)
        else
          notice = "Невозможно добавить окрашивание на это время, так как данная услуга займет около 2 часов! А следующие два часа уже заняты! Пожалуйста, выберите другое время."
        end
      end
    end

    if notice.nil?
      record_service.save
      render_record_services
    else
      record_service.destroy
      render_notice(notice)
    end
  end

  def destroy
    success = record_service.destroy

    render_record_services if success
  end

  private

  def render_record_services
    respond_to do |format|
      format.html
      format.js { render 'record_services/_record_services' }
    end
  end

  def render_notice(notice)
    respond_to do |format|
      format.html
      format.js { render 'record_services/_notice', locals: { notice: notice } }
    end
  end

  def record_services_params
    params.require(:record_service).permit(:record_id, :service_id).merge(record_id: record.id)
  end
end
