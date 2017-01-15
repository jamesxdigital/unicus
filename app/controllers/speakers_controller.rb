class SpeakersController < ApplicationController
  layout :resolve_layout
  load_and_authorize_resource

  def speakers
    @speakers = Speaker.all
    render :index
  end

  def add_speaker
    @speaker = Speaker.new
    render :new
  end

  def new
    @speaker = Speaker.new
  end

  def edit_speaker
    @speakers = Speaker.all
    render :index
  end

  def delete_speaker
    @speakers = Speaker.all
    render :index
  end

  def index
    @speakers = Speaker.all
  end

  def show
    @speaker = Speaker.find(params[:id])
    @speakers = Speaker.all
    render :index
  end

  def edit
    @speaker = Speaker.find(params[:id])
  end

  def update
  @speaker = Speaker.find(params[:id])

  if @speaker.update(speaker_params)
    redirect_to speakers_path
  else
    render :edit
  end
end

def destroy
  @speaker = Speaker.find(params[:id])
  @speaker.destroy

  redirect_to speakers_path
end

  def create
    @speaker = Speaker.new(speaker_params)

    if @speaker.save
      flash[:notice] = "successfully Submit!"
      redirect_to :layout => "application", :controller => 'pages', :action => 'index'
       else
         flash[:alert] = "Submit Failed, Same Email has been saved!"
         redirect_to :layout => "application", :controller => 'pages', :action => 'biography'
     end
   end

  private
    def speaker_params
      params.require(:speaker).permit(:display_email, :linkedIn, :avatar, :avatar_cache, :speaker_title, :forename, :surname, :organisation, :biography, :academic_background, :email, :website, :facebook, :twitter)
    end

    def resolve_layout
      if current_user.nil? || current_user.role == "Default"
        "application"
      else
        "cp_layout"
      end
    end
  end
