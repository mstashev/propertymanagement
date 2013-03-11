class Ability
  include CanCan::Ability

  def initialize(thisuser)

    thisuser ||= User.new

    if thisuser.has_role? :manager
      can :manage, :all
    else
      if thisuser.has_role? :renter
        can :manage, thisuser
        can [:read], [Property, Unit]
        can :read, Lease, :active => true, :user_id => thisuser
      end
      can :index, :all
      can :create, User
    end
  end

end 