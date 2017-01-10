class CostsController < ApplicationController
  expose(:costs) { Cost.all }
  expose(:cost)

  def create
    cost = Cost.create(costs_params)
    success = cost.save

    redirect_to costs_path if success
  end

  def destroy
    success = cost.destroy

    redirect_to costs_path if success
  end
  private

  def costs_params
    params.require(:cost).permit(:name)
  end
end
