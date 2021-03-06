class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  def index
    @active_users = User.active.by_role.alphabetical
    @inactive_users = User.inactive.by_role.alphabetical
    @online_users = User.active.online.by_role.alphabetical
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    @user.save!
    if @user.save #Create random username and role upon successful Google Authentication
      @user.username = "user-#{ SecureRandom.hex(10)}" 
      @user.role = 'student' # Not needed via default but ensures security if role modified in request transit.
      @user.save!
      session[:user_id] = @user.id
      flash[:notice] =  "Thanks for signing up! Start a chatroom!"
      redirect_to chatrooms_path
    else
      redirect_to signup_path, flash[:notice] =  user.errors.messages
    end
  end

  def edit
  end

  def update
    # Keep session active if admin modifies or deactivates a user. 
    if @user.update(user_params) && current_user.role == 'admin'
      if @user.active == false
        flash[:notice] ="#{@user.name} is no longer active in the system."
      else 
        flash[:notice] ="#{@user.name} is updated."
      end
      redirect_to @user
    # End session if user deletes his or her own account.
    elsif @user.update(user_params) && current_user.role != 'admin'
      if @user.active == false
        flash[:notice] = "Your account has been deleted."
        redirect_to signout_path 
      end   
    else
      render :action => 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
      params.require(:user).permit(:username, :active, :name, :role, :id)
    end


end