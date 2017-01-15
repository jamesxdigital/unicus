class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @minions = User.where(["manager_id=?",current_user.id])
    @minions_details = Array.new
    @minions_id = Array.new
    @minions.each do |minion|
      @minions_id << minion.id
      @minions_details << [minion.id,minion.email,minion.givenname,minion.sn]
    end
    @requests = Request.where(user_id:@minions_id)
    respond_to do |format|
      format.html
      format.csv { send_data @requests.to_csv }
    end
  end

  def destroy_all
    @minions = User.where(["manager_id=?",current_user.id])
    @minions_id = Array.new
    @minions.each do |minion|
      @minions_id << minion.id
    end
    @requests = Request.where(user_id:@minions_id)

    @requests.each do |request|
      request.destroy
    end
    redirect_to(:root)

  end


  def new
    @request = Request.new
  end

  def create

    @request = Request.new(request_params)
    @request.user_id = current_user.id
    if @request.save
      redirect_to :root, notice: 'Training category was successfully created.'
    else
      redirect_to :root, notice: 'Training category failed to be created'
    end
  end


  private
  def set_request
    @request = Request.find(params[:id])
  end
  def request_params
   params.require(:request).permit(:user_id,:category,:comments)
  end

end
