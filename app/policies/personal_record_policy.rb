class PersonalRecordPolicy < ApplicationPolicy
  def create?
    user.personal_balances.include? record.personal_balance
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end