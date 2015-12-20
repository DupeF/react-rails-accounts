class GroupsController < ApplicationController

  def create
    @group = current_user.groups.create group_params
    skip_authorization
    if @group.errors
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def show
    @group = Group.find(params[:id])
    authorize @group
    @users = @group.users.select(:id, :email)
    raw_records = @group.records.includes(:payer, :users).order(date: :desc, created_at: :desc).page(params[:page]).per(10)
    @records = raw_records.map do |record|
      record.attributes.merge(
          {
              'payer' => record.payer.slice(:id, :email),
              'users' => record.users.map { |u| u.slice(:id, :email)}
          }
      )
    end
    @total_pages = raw_records.total_pages
    render json: { records: @records, total_pages: @total_pages } if request.xhr?
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
