class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :find_resolutions, Resolution
    can :search, Resolution
    can :registered, Resolution
    can :approved, Resolution
    can :passed, Resolution
    can :failed, Resolution
    can :undebated, Resolution

    if user.is?("can register resolutions")
        can :manage, Resolution
    end
    if user.is?("can approve resolutions")
        can :read, Resolution
        can :update, Resolution
    end
    if user.is?("can pass/fail resolutions")
        can :read, Resolution
        can :update, Resolution
    end
    if user.is?("can print resolutions")
        can :read, Resolution
        can :download_all, Resolution
        can :download_registered, Resolution
        can :download_approved, Resolution
        can :download_passed, Resolution
        can :download_failed, Resolution
        can :download_undebated, Resolution
    end
    if user.is?("full access rights")
        can :manage, Resolution
        can :download_all, Resolution
        can :download_registered, Resolution
        can :download_approved, Resolution
        can :download_passed, Resolution
        can :download_failed, Resolution
        can :download_undebated, Resolution
    end

  end
end
