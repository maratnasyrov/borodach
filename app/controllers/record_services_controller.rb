class RecordServicesController < ApplicationController
  expose(:record)
  
  expose(:record_services)
  expose(:record_service, attributes: :record_services_params)

  def create
    record_service = RecordService.create(record_services_params)
    success = record_service.save
    render_record_services if success
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

  def record_services_params
    params.require(:record_service).permit(:record_id, :service_id).merge(record_id: record.id)
  end
end
