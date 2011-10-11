class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index,:create,:update], Event
    if user
      can :destroy, Event
    end
  end
end
