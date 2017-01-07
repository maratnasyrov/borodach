class MastersController < ApplicationController
  expose(:masters) { Master.all }
  expose(:master)

  def create
    master = Master.create(masters_params)
    success = master. save
    
    redirect_to root_path if success
  end

  def destroy
    master.destroy
    redirect_to root_path
  end

  private

  def masters_params
    params.require(:master).permit(:name, :last_name)
  end
end
