class AdminAbility
  include CanCan::Ability
 
  def initialize(admin_user)
    admin_user ||= AdminUser.new

    if (admin_user.role == 'Conference Manager')
      can :read, ActiveAdmin::Page, :name => "Dashboard"
      can :read, Conference
      can :manage, User
      can :manage, Resolution
    else
      can :manage, :all
    end
 
  end
end