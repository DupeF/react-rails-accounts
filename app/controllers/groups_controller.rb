class GroupsController < ApplicationController

  def create
    # @balance = current_user.personal_balances.new personal_balance_params
    # skip_authorization
    # if @balance.save
    #   render json: @balance
    # else
    #   render json: @balance.errors, status: :unprocessable_entity
    # end
  end

  def show
    @group = Group.find(params[:id])
    authorize @group
    @records = @group.records.order(date: :desc, created_at: :desc).page(params[:page]).per(10)
    @total_pages = @records.total_pages
    render json: { records: @records, total_pages: @total_pages } if request.xhr?
  end

  private

  # def personal_balance_params
  #   params.require(:personal_balance).permit(:name)
  # end
end
