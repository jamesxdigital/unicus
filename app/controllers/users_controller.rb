class UsersController < ApplicationController


#needs to know the user before authorizing them...
  before_action :find_user, only:[:show,:edit,:destroy,:update]
  authorize_resource

  def index
    @users = User.all
    puts "THIS HAPPENS!"
    puts "****   #{@users.length}"
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def edit
    @current_nav_identifier = :users
    @user = User.find(params[:id])
    @users = User.all
    @manager_users = User.where(manager:"t")
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: 'user was successfully destroyed.'
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_url, notice: 'Your details were successfully updated'
    else
      render :edit
    end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email,:manager,:admin,:manager_id)
    end

end
