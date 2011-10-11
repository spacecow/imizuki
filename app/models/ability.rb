class Ability
  include CanCan::Ability

  def initialize(user)
    can [:view,:create,:update], Event
  end
end
