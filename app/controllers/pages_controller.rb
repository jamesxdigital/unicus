class PagesController < ApplicationController
  # authorize_resource :class => false
  # skip_authorize_resource :only => :index
  #authorize_resource
  def index
    #@spksize = Speaker.where("to_display = 1").count
    @spksize = User.where("role = 'Default'").count
    #@att = User.count
    @speakerF = Speaker.take(4)
    @frontpv = Frontpv.first
    #  authorize! :show, current_user
  end

  def lecture
    authorize! :lecture, :home
    @lecturesX = Lecture.find(params[:id])

    @speakerS = Speaker.where("email = '#{@lecturesX.key_speaker}'").first
    @calendar = Calendar.new()
    @days = Day.all
  end

  def schedule
    authorize! :schedule, :home
    @days = Day.all
    @lectures1=Lecture.order(start_time: :asc).where("day_id = ? AND column_name = ?", params[:time], 'Splitting')
    @lectures2=Lecture.order(start_time: :asc).where("day_id = ? AND column_name = ?", params[:time], 'Insertion')
    @lectures3=Lecture.order(start_time: :asc).where("day_id = ? AND column_name = ?", params[:time], 'Enabling')
    @lectures4=Lecture.order(start_time: :asc).where("day_id = ? AND column_name = ?", params[:time], 'Extra')
    @lecturesPS=Lecture.order(start_time: :asc).where("day_id = ? AND column_name = ?", params[:time], 'Plenary Session')
    @lecturesCB=Lecture.order(start_time: :asc).where("day_id = ? AND column_name = ?", params[:time], 'Coffee Break')
  end

  def speaker
    authorize! :speaker, :home

    if params[:id].present?
      @speakerX = Speaker.find(params[:id])
    else
      @speakerX = Speaker.find_by_email(params[:email])
    end
  end

  def days
    authorize! :days, :home
    @days = Day.all
    @dayX = @days.sort_by {|x| [x.ddatey,x.ddatem,x.ddated] }

  end

  def speakers
    authorize! :speakers, :home
    @speakerA = Speaker.all

  end

  def account
    authorize! :account, :home
  end

  def notifications
    authorize! :notifications, :home
  end

  def biography
    authorize! :biography, :home
    @speaker = Speaker.find_by_email(current_user.email)
  end

  def biography_update
    authorize! :biography_update, :home
    @speaker = Speaker.find_by_email(current_user.email)
    if @speaker.update(biography_params)
      flash[:notice] = "Biography successfully updated"
      redirect_to "/speaker?id=#{@speaker.id}"
    else
      flash[:alert] = "A problem occured while updating"
      render 'biography'
    end
  end

  private
  def biography_params
    params.require(:speaker).permit(:to_display, :speaker_title, :forename, :surname, :organisation, :display_email, :biography, :academic_background, :website, :facebook, :twitter, :linkedIn, :avatar, :avatar_cache, :remove_avatar)
  end


end
