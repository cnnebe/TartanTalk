# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      #If chatroom is anonymous, display username
      if message.user.name == nil or message.chatroom.anonymous == true
      ActionCable.server.broadcast 'messages',
        message: message.content,
        user: message.user.username
      head :ok

      else  #If chatroom is non anonymous, display name.
      ActionCable.server.broadcast 'messages',
        message: message.content,
        user: message.user.name
      head :ok
      end
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id)
    end
end