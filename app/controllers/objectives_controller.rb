class ObjectivesController < ApplicationController

  before_action :set_objective, only: [:show, :edit, :update, :destroy, :approve_confirm, :approve, :reject_confirm, :reject, :show_unapproved,:show_rejected]
  authorize_resource

  # GET /objectives
  def index
      @all_objectives = Objective.where(["user_id=?",current_user.id])
      @objectives = @all_objectives.where(status:1)

      @rejects_count = @all_objectives.where(status: 2).count

      if current_user.manager?
        @minions = User.where(["manager_id=?",current_user.id])

        @minion_ids = Array.new # hold minion info
        minionids = Array.new # holds minion ID's only
        #minion_emails = Array.new

        @minions.each do |minion|
          @minion_ids << [minion.email,minion.id,minion.givenname,minion.sn]
          minionids << minion.id
        end
        @manager_objectives = Objective.where(user_id:minionids).where(status: 1)
      end
  end

  #requested index

  def requested
    @all_objectives = Objective.where(["user_id=?",current_user.id])
    @pending_objectives = @all_objectives.where(status:0)
    @rejected_objectives = @all_objectives.where(status:2)
  end

  # GET /objectives/1
  def show
    @user = User.find_by_id(@objective.user_id)
  end

  # GET /objectives/new
  def new

    puts "*************"
    if params[:request_type]
      puts params[:request_type]
    else
      puts "params[:request_type] not found!"
    end
    puts "*************"


    @request_type = params[:request_type]
    @objective = Objective.new
    @can_full_edit = true
    @minions = User.where(["manager_id=?",current_user.id])
  end

  # GET /objectives/1/edit
  def edit
    #@minions = User.where(["manager_id=?",current_user.id])
    @objective_user = User.find(@objective.user_id)
    @can_full_edit = false
    if @objective_user.manager_id == current_user.id
      @can_full_edit = true
    end
    @minions = User.where(["manager_id=?",current_user.id])
  end
  # POST /objectives
  def create

    if params[:request_type] == "self"
      puts "**** self detected ***"
      @objective = Objective.new(objective_params)
      @objective.user_id = current_user.id
      if @objective.save
        puts "SUCCESS ON SAVING OBJECTIVE FOR USER: #{@objective.user_id}"

        #add message to managers inbox
        m = Message.new
        m.user_id = current_user.manager_id
        m.content_id = @objective.id
        m.sender_id = current_user.id
        m.message_type = "new_objective_notification"
        m.title = "#{current_user.givenname} #{current_user.sn} proposed new objective!"
        m.message = "#{params[:message_to_manager]}"
        m.seen = false
        m.save



        mailerSettings = getMailerSettings(current_user.manager_id)

        if mailerSettings.when_objective_proposed == true
          obj_manager = User.find_by_id(current_user.manager_id)
          message = "#{current_user.givenname} #{current_user.sn} proposed a new objective on #{@objective.created_at.strftime("%d/%m/%Y - %I:%M%p")} . You can now approve or reject it on UNICUS web system."
          UserMailer.email_notification(obj_manager,current_user,"Employee proposed new objective!",message).deliver_later
        end

        flash[:notice] = "Success!"
        errors_count = 0

      else
        puts "ERROR!! COULD'NT SAVE OBJECTIVE"
        errors_count+=1
      end

    else #start of Else

    puts "*******"
    puts params[:objective][:user_id][1]
    puts params[:objective][:user_id].length
      puts "status: #{params[:objective][:status]}"
    puts "******"

    errors_count = 0

    for i in 1..params[:objective][:user_id].length-1
      @objective = Objective.new(objective_params)
      @objective.user_id = params[:objective][:user_id][i]

      if @objective.save
        puts "SUCCESS ON SAVING OBJECTIVE FOR USER: #{@objective.user_id}"

        #adding system message
        m = Message.new
        m.user_id = @objective.user_id
        m.content_id = @objective.id
        m.sender_id = current_user.id
        m.message_type = "assigned_objective_notification"
        m.title = "#{current_user.givenname} #{current_user.sn} assigned new objective!"
        m.message = "#{current_user.givenname} #{current_user.sn} created a new objective for you! click link below to see it."
        m.seen = false
        m.save

        #sending email_notification
        mailerSettings = getMailerSettings(@objective.user_id)

        if mailerSettings.when_objective_added == true
          user_to = User.find_by_id(@objective.user_id)
          message = "#{current_user.givenname} #{current_user.sn} added new objective for you, it is due #{@objective.deadline.strftime("%d/%m/%Y - %I:%M%p")} . You can now view it in UNICUS web system."
          UserMailer.email_notification(user_to,current_user,"Manager added a new objective for you!",message).deliver_later
        end

      else
        puts "ERROR!! COULD'NT SAVE OBJECTIVE"
        errors_count+=1
      end
    end

    end # End of else ^

      if errors_count == 0
        flash[:notice] = "Objective successfully added."
        redirect_to(objectives_path)
        return
      else
        flash[:notice] = "#{errors_count} errors encountered while adding objectives."
        redirect_to(objectives_path)
        return
      end



    #@objective = Objective.new(objective_params)
    #@objective.user_id = params[:objective][:user_id][1]



    #if @objective.save
    #  redirect_to @objective, notice: 'Objective was successfully created.'
    #else
    #  render :new
    #end
  end

  # PATCH/PUT /objectives/1
  def update
    if @objective.update(objective_params)
      redirect_to @objective, notice: 'Objective was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /objectives/1
  def destroy
    @objective.destroy

    case params[:rto]
    when "unapproved"
     redirect_to unapproved_objectives_url, notice: 'Objective was successfully destroyed.'
    when "requested"
     redirect_to requested_objectives_url, notice: 'Objective was successfully destroyed.'
    else
     redirect_to objectives_url, notice: 'Objective was successfully destroyed.'
    end


  end



  def unapproved

        @minions = User.where(["manager_id=?",current_user.id])


        @minion_ids = Array.new # hold minion info
        minionids = Array.new # holds minion ID's only
        #minion_emails = Array.new

        @minions.each do |minion|
          @minion_ids << [minion.email,minion.id,minion.givenname,minion.sn]
          minionids << minion.id
        end

        @manager_objectives = Objective.where(user_id:minionids).where(status: 0)

  end

  def show_unapproved
    @user = User.find_by_id(@objective.user_id)
    @allow_approval = false
    if @user.manager_id == current_user.id
      @allow_approval = true
    end
    @path_to = params[:from]
    puts "Coming from: #{params[:from]}"
    render('show')
  end

  def show_rejected
    @user = User.find(@objective.user_id)
    @message = Message.where(content_id: @objective.id).where(message_type:"rejection_notification").first
    @rejector = User.find(@message.sender_id)
  end

  def approve_confirm #comfirmation screen
    @user = User.find(@objective.user_id)
  end

  def approve
    @objective.status = 1

      if @objective.save
        flash[:notice] = "SUCCESS ON SAVING OBJECTIVE"
      else
        flash[:notice] =  "ERROR!! COULD'NT SAVE OBJECTIVE"
        errors_count+=1
      end
      puts "message to user: "
      puts "#{params[:message]}"

      m = Message.new
      m.user_id = @objective.user_id
      m.content_id = @objective.id
      m.sender_id = current_user.id
      m.title = "Your objective '#{@objective.title}' has been approved!"
      m.message_type = "approval_notification"
      m.seen = false
      m.message = params[:message]
      if m.save
        puts "New message created."
      else
        puts "Failed to create new message."
      end

      #sending email_notification

      mailerSettings = getMailerSettings(@objective.user_id)

      if mailerSettings.when_objective_approved == true
        user_to = User.find_by_id(@objective.user_id)
        message = "Your objective '#{@objective.title}' has been approved!, it is due #{@objective.deadline.strftime("%d/%m/%Y - %I:%M%p")} . You can now view it in UNICUS web system."
        UserMailer.email_notification(user_to,current_user,"Your objective has been approved!",message).deliver_later
      end


    redirect_to(unapproved_objectives_url)

  end


  def reject_confirm
   @user = User.find(@objective.user_id)
  end

  def reject
    @objective.status = 2

      if @objective.save
        flash[:notice] = "SUCCESS ON SAVING OBJECTIVE"
      else
        flash[:notice] =  "ERROR!! COULD'NT SAVE OBJECTIVE"
        errors_count+=1
      end
      puts "message to user: "
      puts "#{params[:message]}"

      m = Message.new
      m.user_id = @objective.user_id
      m.sender_id = current_user.id
      m.content_id = @objective.id
      m.title = "Your objective '#{@objective.title}' have been rejected!"
      m.message_type = "rejection_notification"
      m.seen = false
      m.message = params[:message]
      if m.save
        puts "New message created."
      else
        puts "Failed to create new message."
      end


      #sending email_notification
      mailerSettings = getMailerSettings(@objective.user_id)
      if mailerSettings.when_objective_rejected == true
        user_to = User.find_by_id(@objective.user_id)
        message = "Your objective '#{@objective.title}' has been rejected!. Please ,check UNICUS web system for details!"
        UserMailer.email_notification(user_to,current_user,"Your objective has been rejected!",message).deliver_later
      end
    redirect_to(unapproved_objectives_url)

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objective
      @objective = Objective.find(params[:id])
    end


    # Only allow a trusted parameter "white list" through.
    def objective_params
      params.require(:objective).permit(:user_id,:title,:description,:completed,:deadline,:status,user_id: [])
    end
end
