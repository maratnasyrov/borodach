class SalonsController < ApplicationController
  expose(:salons) { Salon.all }
  expose(:salon)

  def create
    salon = Salon.create(salons_params)
    success = salon.save

    redirect_to salons_path if success
  end

  def destroy
    success = salon.destroy

    redirect_to salons_path if success
  end
  private

  def salons_params
    params.require(:salon).permit(:name, :address)
  end
end
