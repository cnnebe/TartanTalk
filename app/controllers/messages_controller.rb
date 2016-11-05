#Messages are a separate entity controlled here
class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      #If the user is an anonymous session or selects anonymous, display username
      if message.user.name == nil or message.user.anonymous == true
      ActionCable.server.broadcast 'messages',
        message: message.content,
        user: message.user.username
      head :ok

      else  #If user registered and doesn't want anonimity, display name.
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