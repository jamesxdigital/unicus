class FrontpvsController < ApplicationController
  layout :resolve_layout
  load_and_authorize_resource

  def edit_form
    @frontpv = Frontpv.first
  end

  def update_form
    @frontpv = Frontpv.first
    if @frontpv.update(frontpv_params)
      flash[:notice] = "Values were updated"
      redirect_to root_path
    else
      flash[:alert] = "There was an error in the database"
      render 'edit_form'
    end
  end


  private

  def frontpv_params
    params.require(:frontpv).permit(:title, :message)
  end

  def resolve_layout
    if current_user.nil? || current_user.role == "Default"
      "application"
    else
      "cp_layout"
    end
  end
end
