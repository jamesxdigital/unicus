class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)


    if user.admin?
      can :manage, User
      can :manage, CompanyValue
      can :manage, TrainingCategory
      can [:new,:create, :requested,:edit,:update,:read,:show_unapproved,:show_rejected], Objective
      can [:new,:create], Request
      can [:edit, :update, :read, :show_photo], PeerReview
    end

    if user.manager?
      can :manage, Objective
      can :manage, Request
      can :manage, PeerReview
    end
    if not(user.manager? or user.admin?)
      can [:new,:create, :requested,:edit,:update,:read,:show_unapproved,:show_rejected], Objective
      can [:new,:create], Request
      can [:edit, :update, :read, :show_photo], PeerReview
    end


  end
end
