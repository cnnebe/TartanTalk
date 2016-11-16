# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class ChatroomsController < ApplicationController

  def index
    #Chatrooms
    #@chatroom = Chatroom.new
    @chatrooms = Chatroom.all

    #All Active Private and Public 
    @active_public_chatrooms = Chatroom.active.nonstaff.publicchat.recent
    @active_private_chatrooms = Chatroom.active.nonstaff.privatechat.recent

    #All Archived/Inactive Private and Public 
    @inactive_public_chatrooms = Chatroom.inactive.nonstaff.publicchat.alphabetical 
    @inactive_private_chatrooms = Chatroom.inactive.nonstaff.privatechat.alphabetical 

    #Anon Lists
    @active_public_anon_chatrooms = Chatroom.active.nonstaff.publicchat.anonymous.recent
    @active_private_anon_chatrooms = Chatroom.active.nonstaff.privatechat.anonymous.recent

    #Non-Anon Lists
    @active_public_nonanon_chatrooms = Chatroom.active.nonstaff.publicchat.nonanonymous.recent
    @active_private_nonanon_chatrooms = Chatroom.active.nonstaff.privatechat.nonanonymous.recent

    #Emergency 
    @emergency = Chatroom.emergency.recent
    @active_emergency_chatrooms = Chatroom.active.emergency.recent
    @inactive_emergency_chatrooms = Chatroom.inactive.emergency.recent

    #Staff
    @active_staff_chatrooms = Chatroom.active.staff.recent
    @inactive_staff_chatrooms = Chatroom.inactive.staff.alphabetical

    #Professional/Peer Chat
    @active_private_professional_chatrooms = Chatroom.active.privatechat.professional.recent
    @active_private_peer_chatrooms = Chatroom.active.privatechat.peer.recent
    @active_public_professional_chatrooms = Chatroom.active.publicchat.professional.recent
    @active_public_peer_chatrooms = Chatroom.active.publicchat.peer.recent

    @inactive_private_professional_chatrooms = Chatroom.inactive.privatechat.professional.recent
    @inactive_private_peer_chatrooms = Chatroom.inactive.privatechat.peer.recent
    @inactive_public_professional_chatrooms = Chatroom.inactive.publicchat.professional.recent
    @inactive_public_peer_chatrooms = Chatroom.inactive.publicchat.peer.recent

    #@active_unclaimed_chatrooms = Chatroom.active.allcounselors.recent

  end

  def new
    if request.referrer && request.referrer.split("/").last == "chatrooms"
    end
    @chatroom = Chatroom.new
  end

  def edit
    @chatroom = Chatroom.find_by(slug: params[:slug])
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      flash[:notice] =  "Chatroom successfully created! Feel free to send a message!"
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js
      end
    else
      flash[:notice] =  @chatroom.errors.messages
      redirect_to new_chatroom_path
     # respond_to do |format|
     #   flash[:notice] = {error: ["a chatroom with this topic already exists"]}
     #   format.html { redirect_to new_chatroom_path }
     #   format.js { render template: 'chatrooms/chatroom_error.js.erb'} 
     # end
    end
  end

  def update
    chatroom = Chatroom.find_by(slug: params[:slug])
    chatroom.update(chatroom_params)
    redirect_to chatroom
  end

  def show
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @message = Message.new
  end

  private

    def chatroom_params
      params.require(:chatroom).permit(:topic, :counselor_type, :counselor, :active, :staff, :private, :emergency, :user_id, :anonymous)
    end
end
