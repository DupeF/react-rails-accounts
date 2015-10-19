class PersonalBalancesController < ApplicationController

  def show
    @balance = policy_scope PersonalBalance
    @records = @balance.records.order(date: :desc, created_at: :desc).page(params[:page]).per(10)
    @total_pages = @records.total_pages
    skip_authorization
    render json: { records: @records, total_pages: @total_pages } if request.xhr?
  end

end
