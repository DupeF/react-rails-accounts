class PersonalBalancesController < ApplicationController

  def show
    @balance = policy_scope PersonalBalance
    skip_authorization
  end

end
