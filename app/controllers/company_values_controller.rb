class CompanyValuesController < ApplicationController
  before_action :set_company_value, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @values = CompanyValue.all
  end

  def new
    @value = CompanyValue.new
  end

  def create
    @value = CompanyValue.new(value_params)
    if @value.save
      redirect_to '/company_values'
    else
      render 'new'
    end
  end

  def update
    if @value.update(value_params)
      redirect_to company_values_path, notice: 'Value successfully updated.'
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @value.destroy
    redirect_to company_values_path, notice: 'Value successfully deleted.'
  end

  private

    def set_company_value
      @value = CompanyValue.find(params[:id])
    end

    def value_params
      params.require(:company_value).permit(:company_value, :icon, :colour)
    end
end
