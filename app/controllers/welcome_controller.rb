# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!

  def about
   
  end
end