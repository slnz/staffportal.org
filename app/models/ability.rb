class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin == "admin"
      can :manage, :all
    end
    if user.admin == "coach"
      can :manage, Week6, :user => {:bootcamp_coach_id => user.id}
      can :manage, Week5, :user => {:bootcamp_coach_id => user.id}
    end

    if user.admin == "hr"
      can :manage, Week6
      can :manage, Week5
    end
  end
end