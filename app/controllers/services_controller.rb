class ServicesController < ApplicationController
  expose(:services) { Service.all }
  expose(:service)
  expose(:master)

  def create
    success = Service.create(services_params)
    respond_with service if success
  end

  def update
    success = Service.update(services_params)
    respond_with service if success
  end

  def destroy
    success = service.destroy
    respond_with service if success
  end

  private

  def services_params
    params.require(:service).permit(:name, :price, :time, :coloration).merge(master_id: master.id)
  end
end
