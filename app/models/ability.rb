class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

  if user.role == 'Administrator'
    can :manage, :all
  elsif user.role == 'Moderator'
    can [:edit, :update,:index, :new, :create, :chg, :chgpsw], User
    can :manage, Notification
    can :manage, Frontpv
    can :manage, Calendar
    can :manage, Lecture
    can :manage, Day
    can :manage, Speaker
    can :cpHome, :home
    can :schedule, :home
    can :lecture, :home
    can :speaker, :home
    can :days, :home
    can :speakers, :home
    can :account, :home
    can :notifications, :home
    can :biography, :home
    can :biography_update, :home
  elsif user.role == 'Default'
    can [:chg, :chgpsw], User do |usr|
      usr.try(:id) == user.id
    end
    can :usernotifications, Notification
    can :manage, Calendar
    can :schedule, :home
    can :lecture, :home
    can :speaker, :home
    can :days, :home
    can :speakers, :home
    can :account, :home
    can :notifications, :home
    can :biography, :home
    can :biography_update, :home
  else
  end

  end
end
