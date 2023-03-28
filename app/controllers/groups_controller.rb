class GroupsController < ApplicationController
  def index
    @groups = Group.all.where(user: current_user).includes(:operations)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to groups_path
      flash[:notice] = 'Group created successfully'
    else
      flash[:error] = "Group didn't get saved"
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end