class CpController < ApplicationController
  layout :resolve_layout

  def cpHome
    authorize! :cpHome, :home
  end

  def resolve_layout
    if current_user.nil?
      "application"
    else
      "cp_layout"
    end
  end
end
