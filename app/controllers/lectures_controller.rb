class LecturesController < ApplicationController
  layout :resolve_layout
  load_and_authorize_resource

  def lectures
    @lectures = Lecture.all
    render :index
  end

  def add_lecture
    @lecture = Lecture.new
    render :new
  end

  def new
    @lecture = Lecture.new
    @speakers = Speaker.all
    @days = Day.all
    @calendar = Calendar.new
  end

  def edit_lecture
    @lectures = Lecture.all
    render :index
  end

  def delete_lecture
    @lectures = Lecture.all
    render :index
  end

  def index
    @lectures = Lecture.all
  end

  def show
    @lecture = Lecture.find(params[:id])
    @lectures = Lecture.all
    render :index
  end

  def edit
    @lecture = Lecture.find(params[:id])
  end

  def update
    @lecture = Lecture.find(params[:id])

  if @lecture.update(lecture_params)
    redirect_to lectures_path
  else
    render :edit
  end
end

def destroy
  @lecture = Lecture.find(params[:id])
  @lecture.destroy

  redirect_to lectures_path
end

  def create
    @speakers = Speaker.all
    @lecture = Lecture.new(lecture_params)

    if @lecture.save
       redirect_to lectures_path
       else
         render 'new'
     end
  end

  private
    def resolve_layout
      if current_user.nil? || current_user.role == "Default"
        "application"
      else
        "cp_layout"
      end
    end
    def lecture_params
      params.require(:lecture).permit(:lecture_title, :is_break, :day_id, :column_name, :start_time, :end_time, :location, :key_speaker, :description)
    end
end
