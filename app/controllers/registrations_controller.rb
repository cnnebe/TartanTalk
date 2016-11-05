#Registration (TODO: Needs updating)
class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create 
    user = User.new(user_params)
    user.save!
    if user.save
      user.username = "user-#{ SecureRandom.hex(10)}" 
      user.active = true
      user.anonymous = true
      user.role = 'student'
      user.save!
      session[:user_id] = user.id
      redirect_to chatrooms_path
    else
      redirect_to signup_path, flash[:notice] =  user.errors.messages
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :active, :anonymous, :name, :role)
    end
end