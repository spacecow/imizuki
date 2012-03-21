class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show,:index], Event
    can [:show,:index], Picture
    if user
      if user.role? :member
        can :show, User
      end
      if user.role? :admin
        can [:create,:update,:destroy], Event
        can [:edit,:last], Picture
      end
    end
  end
end
