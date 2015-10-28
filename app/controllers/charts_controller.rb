class ChartsController < ApplicationController

  def balance
    @balance = policy_scope PersonalBalance
    @balance_chart = Charts::Balance.for_balance @balance
    skip_authorization
    render json:
               {
                   chart_type: @balance_chart.chart_type,
                   formatted_data: @balance_chart.formatted_data,
                   options: @balance_chart.options
               }
  end
end