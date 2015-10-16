class GroupMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  ADMIN = 'admin'
  MEMBER = 'member'
end
