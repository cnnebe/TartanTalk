# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create 
    user = User.new(user_params)
    user.save!
    if user.save # Create username for user on account creation for one-time use accounts.
      user.username = "user-#{ SecureRandom.hex(10)}" 
      user.role = 'student' # Not necessary via default role but puts in added security in case of abuse of one-time account
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