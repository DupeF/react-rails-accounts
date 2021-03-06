class GroupMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates_presence_of :user, :group

  ADMIN = 'admin'
  MEMBER = 'member'
end
