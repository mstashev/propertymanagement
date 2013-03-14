class Lease < ActiveRecord::Base
  attr_accessible :end_date, :rent, :start_date, :unit_id, :user_id

  belongs_to :unit

  has_many :renters, :class_name => "Users"
end
