class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # everyone can read stuff
    can :read, :all
    
    # only admins can edit stuff
    if user.is_admin?
      can :manage, :all
    end
  end
end
