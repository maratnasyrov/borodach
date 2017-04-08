class MastersController < ApplicationController
  expose(:masters) { Master.all }
  expose(:master)

  expose(:users) { User.all }

  def create
    master = Master.create(masters_params)
    success = master. save
    
    redirect_to root_path if success
  end

  def update
    master.update(masters_params)
    master.save

    redirect_to edit_master_path(master)
  end

  def destroy
    master.destroy
    redirect_to root_path
  end

  private

  def masters_params
    params.require(:master).permit(:name, :last_name, :user_id, :phone, :email, :birthday, :about_master, :online_record, :master_active, :avatar)
  end
end
