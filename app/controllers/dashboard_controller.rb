class DashboardController < ApplicationController

  def show
    @balances = policy_scope PersonalBalance
    skip_authorization
  end
end