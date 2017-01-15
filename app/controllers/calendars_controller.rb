class CalendarsController < ApplicationController
  before_action :find_calendar_from_params, only: [:destroy]
  load_and_authorize_resource

  def index
    @calendars = Calendar.where(user_id: current_user.id)
    @scalendars = @calendars.sort_by {|x| [x.ddate, x.ddatem, x.ddated, x.ltime] }
    @lectures = Lecture.all
    @days = Day.all
  end

  def new

  end

  def show

  end

  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      flash[:alert] = "Entry added"
      redirect_to calendars_path
    else
      redirect_to :back, :flash => { :error => "You have already added this lecture!" }
    end
   end

   def destroy
      if @calendar.destroy
        flash[:alert] = "Entry deleted"
        redirect_to calendars_path
      else
        redirect_to :back, :flash => { :error => "Failed to delete!" }
      end
    end



  private
  def find_calendar_from_params
      @calendar = Calendar.find(params[:id])
  end

  def calendar_params
    params.require(:calendar).permit(:user_id, :lectures_id, :ddate, :ddatem, :ddated, :ltime)
  end

end
