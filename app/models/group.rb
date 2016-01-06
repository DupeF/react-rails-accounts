class Group < ActiveRecord::Base
  has_many :records

  has_many :group_memberships
  has_many :users, through: :group_memberships

  validates_presence_of :name
end
