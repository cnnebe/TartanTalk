# Source: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class MessagesChannel < ApplicationCable::Channel  
  def subscribed
    stream_from 'messages'
  end
end  
