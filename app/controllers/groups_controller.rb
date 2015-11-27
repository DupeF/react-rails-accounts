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
    @records = @group.records.order(date: :desc, created_at: :desc).page(params[:page]).per(10)
    @total_pages = @records.total_pages
    render json: { records: @records, total_pages: @total_pages } if request.xhr?
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
