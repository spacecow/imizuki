class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index], Event
    can [:show,:index], Picture
    if user
      can [:create,:update,:destroy], Event
      can :edit, Picture
    end
  end
end
