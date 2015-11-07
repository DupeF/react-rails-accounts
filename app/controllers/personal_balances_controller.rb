class PersonalBalancesController < ApplicationController

  def create
    @balance = current_user.personal_balances.new personal_balance_params
    skip_authorization
    if @balance.save
      render json: @balance
    else
      render json: @balance.errors, status: :unprocessable_entity
    end

  end

  def show
    @balance = PersonalBalance.find(params[:id])
    authorize @balance
    @records = @balance.records.order(date: :desc, created_at: :desc).page(params[:page]).per(10)
    @total_pages = @records.total_pages
    if request.xhr?
      render json: { records: @records, total_pages: @total_pages }
    else
      @total_credits = @balance.records.where('personal_records.amount > 0').sum(:amount)
      @total_debits = @balance.records.where('personal_records.amount < 0').sum(:amount)
    end
  end

  private

  def personal_balance_params
    params.require(:personal_balance).permit(:name)
  end
end
