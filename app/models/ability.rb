class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index], Event
    if user
      can [:create,:update,:destroy], Event
    end
  end
end
