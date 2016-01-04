class DashboardController < ApplicationController

  def show
    @balances = policy_scope PersonalBalance
    @groups = policy_scope Group
    skip_authorization
  end
end