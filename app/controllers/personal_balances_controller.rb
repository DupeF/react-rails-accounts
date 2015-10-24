class PersonalBalancesController < ApplicationController

  def show
    @balance = policy_scope PersonalBalance
    @records = @balance.records.order(date: :desc, created_at: :desc).page(params[:page]).per(10)
    @total_pages = @records.total_pages
    skip_authorization
    if request.xhr?
      render json: { records: @records, total_pages: @total_pages }
    else
      @total_credits = @balance.records.where('personal_records.amount > 0').sum(:amount)
      @total_debits = @balance.records.where('personal_records.amount < 0').sum(:amount)
    end
  end

end
