class UsersController < ApplicationController
  layout :resolve_layout
  before_action :find_user_from_params, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def edit
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.password = ('a'..'z').to_a.shuffle[0,8].join
    if @user.save
      # Tell the RegistrationMailer to send a welcome email after save
      @speaker = Speaker.new(:email => user_params[:email],:to_display => "0")
      if @speaker.save
        puts "smart"
      else
        puts "stupid"
      end
      RegistrationMailer.notify_register(@user).deliver_now
      redirect_to users_url
    else
      flash[:alert] = "Not a valid email"
      render :new
    end
   end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to cp_users_path
    else
      flash[:alert] = "There was a problem updating user"
      render 'edit'
    end
  end

  def chg
    @user = User.find(current_user.id)
  end

  def chgpsw
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_in @user, :bypass => true
      flash[:notice] = "Password was successfully changed"
      redirect_to root_path
    else
      flash[:alert] = "Password should have at least 8 characters"
      render 'chg'
    end
  end

  def destroy
     if @user.destroy
       redirect_to users_url
     else
       flash[:alert] = "Failed to delete"
     end
   end


  private
  def find_user_from_params
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :email, :password, :role, :password_confirmation, :current_password, :current_user, :encrypted_password, :updated_at)
  end

  def resolve_layout
    if action_name == "chg" || current_user.nil? || current_user.role == "Default"
      "application"
    else
      "cp_layout"
    end
  end

end
