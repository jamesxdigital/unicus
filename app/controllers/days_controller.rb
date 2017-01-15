class DaysController < ApplicationController
  layout :resolve_layout
  load_and_authorize_resource

    def cpHome
    end

    def system_settings
    end

    def days
      @days = Day.all
      render :index
    end

    def add_day
      @day = Day.new
      render :new
    end

    def edit_day
      @days = Day.all
      render :index
    end

    def delete_day
      @days = Day.all
      render :index
    end

    def new
      @day = Day.new
    end

    def show
      @day = Day.find(params[:id])
      @days = Day.all
      render :index
    end

    def index
      @days = Day.all
    end

    def edit
      @day = Day.find(params[:id])
    end

    def update
    @day = Day.find(params[:id])

    if @day.update(day_params)
      redirect_to @day
    else
      render :edit
    end
  end

  def destroy
    @day = Day.find(params[:id])
    @day.destroy

    redirect_to days_path
  end

    def create
      @day = Day.new(day_params)
      dayv = day_params[:date]
      puts dayv
      dayd = dayv.split('/')[0]
      daym = dayv.split('/')[1]
      dayy = dayv.split('/')[2]
      @day.ddatey = dayy
      @day.ddatem = daym
      @day.ddated = dayd
      if @day.save
        redirect_to @day
      else
        render :new
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
      def day_params
        params.require(:day).permit(:date, :name, :display_size)
      end
  end
