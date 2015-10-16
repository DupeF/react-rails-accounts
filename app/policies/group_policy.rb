class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.groups
    end
  end

  def show?
    record.users.include? user
  end

end