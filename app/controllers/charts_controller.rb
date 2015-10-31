class ChartsController < ApplicationController

  def balance
    @balance = policy_scope PersonalBalance
    @balance_chart = Charts::Balance.for_balance @balance
    skip_authorization
    render json:
               {
                   type: @balance_chart.chart_type,
                   data: @balance_chart.formatted_data,
                   options: @balance_chart.options
               }
  end
end