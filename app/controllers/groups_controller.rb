class GroupsController < ApplicationController

  def index
    @groups = policy_scope Group
  end

  def show
    @group = Group.find(params[:id])
    authorize @group
  end

end
