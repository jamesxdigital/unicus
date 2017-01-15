class NotificationsController < ApplicationController
  before_action :find_notification_from_params, only: [:destroy,:show]
  load_and_authorize_resource
  layout :resolve_layout

  def index
    @notifications = Notification.all.reverse_order
  end

  def new
    @notification = Notification.new
  end


  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to notifications_path, notice: 'notifications'
    else
      redirect_to :back
    end
   end

   def usernotifications
     @notifications = Notification.all.reverse_order
   end

   def show

   end

   def destroy
     if @notification.destroy
       redirect_to notifications_path, notice: "Notification deleted"
     else
       flash[:alert] = "Failed to delete"
     end
   end

  private
  def find_notification_from_params
      @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:message,:ntype)
  end

  def resolve_layout
    if action_name == "usernotifications" || current_user.nil? || current_user.role == "Default"
      "application"
    else
      "cp_layout"
    end
  end

end
