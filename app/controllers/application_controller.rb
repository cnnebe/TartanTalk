# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # Some Authentication Stuff Here.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

# Source: https://www.google.com/url?q=http://stackoverflow.com/questions/5504130/whos-online-using-devise-in-rails&sa=D&ust=1478418571973000&usg=AFQjCNE7adDErNZZrwNgpbBYVdnJyvVemA
  after_filter :user_activity

  private

# Source: https://www.google.com/url?q=http://stackoverflow.com/questions/5504130/whos-online-using-devise-in-rails&sa=D&ust=1478418571973000&usg=AFQjCNE7adDErNZZrwNgpbBYVdnJyvVemA
  def user_activity
    @current_user.try :touch
  end


  protected
  
  def authenticate_user!
    redirect_to root_path unless logged_in?
  end
end
