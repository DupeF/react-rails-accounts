class RecordPolicy < ApplicationPolicy
  def create?
    user.groups.include? record.group
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end