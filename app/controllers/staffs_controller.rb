class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all.by_role #All Counselors
    @online_users = User.active.online.by_role.alphabetical
    @professionals = Staff.professional
    @peers = Staff.peer
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    @online_users = User.active.online.by_role.alphabetical
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        # If creation successful, we need to change
        # role in actual user account.
        if @staff.is_professional # Change user role to professional if professional staff
          @staff.user.role = "professional"
          @staff.user.save!
        else # Change user role to peer if peer staff
          @staff.user.role = "peer"
          @staff.user.save!
        end
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        if @staff.is_professional # Change user role to professional if professional staff
          @staff.user.role = "professional"
          @staff.user.save!
        else # Change user role to peer if peer staff
          @staff.user.role = "peer"
          @staff.user.save!
        end
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.user.role = "student" # Change role back to default of student if removing staff member.
    @staff.user.save!
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff memer successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:gender, :bio, :is_professional, :user_id)
    end
end
