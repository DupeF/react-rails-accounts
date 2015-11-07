class PersonalBalancePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.personal_balances
    end
  end

  def show?
    record.user_id == user.id
  end
end