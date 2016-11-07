# Source: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
# Future Development: Filter bad words.
class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user


  

  def display_anon
  	if self.user.online? 
  		"(online) #{self.user.username}"
  	else 
  		"(offline) #{self.user.username}"
  	end
  end

  def display_name
  	if self.user.online? 
  		"(online) #{self.user.name}"
  	else 
  		"(offline) #{self.user.name}"
  	end
  end


end
