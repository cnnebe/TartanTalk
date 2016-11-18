# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class ChatroomsController < ApplicationController

  def index
    #Chatrooms
    #@chatroom = Chatroom.new
    @chatrooms = Chatroom.all

    #All Active and Archived Rooms
    @active_chatrooms = Chatroom.active.nonstaff.recent
    @inactive_chatrooms = Chatroom.inactive.nonstaff.alphabetical  

    #Active Chatrooms by Anonymity 
    @active_anon_chatrooms = Chatroom.active.nonstaff.anonymous.recent
    @active_nonanon_chatrooms = Chatroom.active.nonstaff.nonanonymous.recent

    #Emergency Chatrooms 
    @emergency_chatrooms = Chatroom.emergency.recent

    #Staff Chatrooms
    @active_staff_chatrooms = Chatroom.active.staff.recent
    @inactive_staff_chatrooms = Chatroom.inactive.staff.alphabetical

    #Chatrooms Sorted by Counselor Type
    @active_professional_chatrooms = Chatroom.active.professional.recent
    @active_peer_chatrooms = Chatroom.active.peer.recent

    @inactive_professional_chatrooms = Chatroom.inactive.professional.recent
    @inactive_peer_chatrooms = Chatroom.inactive.peer.recent

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
      params.require(:chatroom).permit(:topic, :counselor_type, :counselor, :active, :staff, :emergency, :user_id, :anonymous)
    end
end
