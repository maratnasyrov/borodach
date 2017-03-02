class UsersController < ApplicationController
  expose(:users) { User.all }
  expose(:user, attributes: :user_params)

  def create
    user = User.new(user_params)
    success = user.save

    redirect_to users_path if success
  end

  def destroy
    user.destroy

    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :role)
  end
end
