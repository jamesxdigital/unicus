class SettingsController < ApplicationController

  def index
  	@objective = Objective.new
  	@mail_settings = getMailerSettings(current_user.id)
    @training_category = TrainingCategory.new
    @minions = User.where(["manager_id=?",current_user.id])

    @employees = User.all
    @employee_details = Array.new
    @employees_id = Array.new
    @employees.each do |employee|
      @employees_id << employee.id
      @employee_details << [employee.id,employee.email,employee.givenname,employee.sn]
    end


    puts "MINIONS== #{@minions}"

    @training_categories = TrainingCategory.all
    @requests = Request.all
    respond_to do |format|
      format.html
      format.csv { send_data @requests.to_csv }
    end

  end


end
