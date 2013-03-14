class Ability
  include CanCan::Ability

  def initialize(thisuser)

    thisuser ||= User.new

    if thisuser.has_role? :manager
      can :manage, :all
      can :create, RepairRequest
      can [:index, :manage], RepairRequest, :submitter_id => thisuser.id
      cannot [:edt, :delete], Payment
    else
      if thisuser.has_role? :renter
        can :manage, thisuser
        can [:read], [Property, Unit]
        can :read, Lease, :user_id => thisuser
        can [:index, :manage], RepairRequest, :submitter_id => thisuser.id
        can :read, Payment, :submitter_id => thisuser
        cannot [:edit, :delete], Payment
      end
      can :index, :all
      can :create, User
    end
  end

end 