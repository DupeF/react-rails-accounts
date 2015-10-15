class PersonalBalancesController < ApplicationController

  def show
    @balance = current_user.personal_balance
  end

end
