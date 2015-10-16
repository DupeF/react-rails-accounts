class PersonalRecordPolicy < ApplicationPolicy
  def create?
    record.personal_balance_id == user.personal_balance.id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end