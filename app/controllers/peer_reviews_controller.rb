class PeerReviewsController < ApplicationController
  before_action :set_peer_review, only: [:show, :edit, :update, :destroy, :show_photo]
  authorize_resource

  # GET /peer_reviews
  def index
    @peer_reviews = PeerReview.all
    if current_user.manager?
      @minions = User.where(["manager_id=?",current_user.id])

      @minion_ids = Array.new # hold minion info
      minionids = Array.new # holds minion ID's only
      #minion_emails = Array.new

      @minions.each do |minion|
        @minion_ids << [minion.email,minion.id,minion.givenname,minion.sn]
        minionids << minion.id
      end
      @manager_peer_reviews = PeerReview.where(user_id:minionids)
    end
  end

  # GET /peer_reviews/1
  def show
    @objectives = Objective.where(["user_id=?",current_user.id])
    @objectives = @objectives.where(status:1)

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

  # GET /peer_reviews/2
  def show_photo
    send_file @peer_review.photo.url(:small)
  end

  # GET /peer_reviews/new
  def new
    @minions = User.where(["manager_id=?",current_user.id])
    @peer_review = PeerReview.new

  end

  # GET /peer_reviews/1/edit
  def edit
    @objectives = Objective.where(["user_id=?",current_user.id])
    @objectives = @objectives.where(status:1)

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

  # POST /peer_reviews
  def create

    errors_count = 0

    for i in 1..params[:peer_review][:user_id].length-1
      @peer_review = PeerReview.new(peer_review_params)
      @peer_review.user_id = params[:peer_review][:user_id][i]
      @peer_review.manager_id = current_user.id

        if @peer_review.save
        #redirect_to @peer_review
        #flash[:notice] = "Peer Review successfully updated."
          m = Message.new
          m.user_id = @peer_review.user_id
          m.content_id = @peer_review.id
          m.sender_id = @peer_review.manager_id
          m.message_type = "new_peer_review_notification"
          m.title = "#{current_user.givenname} #{current_user.sn} assigned you a new Peer Review!"
          m.message = "#{current_user.givenname} #{current_user.sn} assigned you a new Peer Review! It must be completed by: #{@peer_review.deadline.strftime("%d/%m/%Y - %I:%M%p")}"
          m.seen = false
          m.save

          mailerSettings = getMailerSettings(@peer_review.user_id)

          if mailerSettings.when_peer_review_added == true
            user_to = User.find_by_id(@peer_review.user_id)
            message = "#{current_user.givenname} #{current_user.sn} assigned you a new Peer Review! It must be completed by: #{@peer_review.deadline.strftime("%d/%m/%Y - %I:%M%p")}. You can complete it on UNICUS web system."
            UserMailer.email_notification(user_to,current_user,"You've been assigned a new Peer Review!",message).deliver_later
          end
        else
          errors_count += 1
        end
    end

    if errors_count > 0
      flash[:notice] = "Saving Peer reviews failed!"
      render :new
    else
      flash[:notice] = "Peer Review successfully updated."
      redirect_to(peer_reviews_url)
    end


  end

  # PATCH/PUT /peer_reviews/1
  def update
    if @peer_review.update(peer_review_params)
      redirect_to @peer_review
      flash[:notice] = "Peer Review successfully updated."

      if current_user.id == @peer_review.manager_id
          m = Message.new
          m.user_id = @peer_review.user_id
          m.content_id = @peer_review.id
          m.sender_id = @peer_review.manager_id
          m.message_type = "manager_updates_peer_review_notification"
          m.title = "#{current_user.givenname} #{current_user.sn} updated your Peer Review!"
          m.message = "Your manager, #{current_user.givenname} #{current_user.sn}, updated your Peer Review! Please review it asap."
          m.seen = false
          m.save

          mailerSettings = getMailerSettings(@peer_review.user_id)

          if mailerSettings.when_peer_review_updated == true
            user_to = User.find_by_id(@peer_review.user_id)
            message = "Your manager, #{current_user.givenname} #{current_user.sn}, updated your Peer Review! Please review it asap. You can do it on UNICUS web system."
            UserMailer.email_notification(user_to,current_user,"#{current_user.givenname} #{current_user.sn} updated your Peer Review!",message).deliver_later
          end
      end
      if current_user.id == @peer_review.user_id
          m = Message.new
          m.user_id = @peer_review.manager_id
          m.content_id = @peer_review.id
          m.sender_id = @peer_review.user_id
          m.message_type = "employee_updates_peer_review_notification"
          m.title = "#{current_user.givenname} #{current_user.sn} updated Peer Review!"
          m.message = "Your employee, #{current_user.givenname} #{current_user.sn}, updated their Peer Review form! Please review it."
          m.seen = false
          m.save

          #sending email notification
          mailerSettings = getMailerSettings(@peer_review.manager_id)

          if mailerSettings.when_peer_review_updated == true
            user_to = User.find_by_id(@peer_review.manager_id)
            message = "Your employee, #{current_user.givenname} #{current_user.sn}, updated Peer Review form! Please review it."
            UserMailer.email_notification(user_to,current_user,"Peer review updated!",message).deliver_later
          end
      end
    else
      render :edit
    end
  end

  # DELETE /peer_reviews/1
  def destroy
    @peer_review.destroy
    redirect_to peer_reviews_url, notice: 'Peer review was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_peer_review
      @peer_review = PeerReview.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def peer_review_params
      params.require(:peer_review).permit(:user_id, :manager_id, :e_objective_response, :e_overall_comments, :e_personal_development, :m_objective_response, :m_overall_comments, :m_personal_development, :deadline, :photo, :photo_cache,user_id: [])
    end
end
