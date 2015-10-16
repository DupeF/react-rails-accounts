class PersonalBalancePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.personal_balance
    end
  end
end