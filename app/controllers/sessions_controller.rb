# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
# Google Auth Source: https://richonrails.com/articles/google-authentication-in-ruby-on-rails

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:destroy]
  

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user === nil 
      user = User.find_by(user_params)
    end 
    if user && !user.active? && user.role != "admin"
      session[:user_id] = user.id
      reset_session
      flash[:notice] =  "Account terminated"
      redirect_to root_path
    elsif user
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in. Start a chatroom or view an existing one!"
      redirect_to chatrooms_path
    else
      flash[:notice] =  "Login failed. If you don't have an account, sign up."
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out. We hope your time on Tartan Talk with helpful."
    redirect_to root_path
  end

  #private

    def user_params
      params.require(:user).permit(:username, :active, :name, :role, :id)
    end
end