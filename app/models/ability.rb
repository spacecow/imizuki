class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Event
  end
end
