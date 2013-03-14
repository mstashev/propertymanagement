class User < ActiveRecord::Base
  attr_accessible :password, :email, :password_confirmation, :username, :role_ids
  acts_as_authentic

  belongs_to :lease

  has_and_belongs_to_many :roles

  has_many :submittedreports, :class_name => 'RepairRequest'
  has_many :approvedreports, :class_name => 'RepairRequest'
  has_many :payments

  after_create :setup_default_role_for_new_users
 
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym}
  end
 
  def setup_default_role_for_new_users
    self.roles = [Role.find(2)]
  end


end
