#Not sure why this is here
class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!

  def about
   
  end
end