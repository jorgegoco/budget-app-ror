class OperationsController < ApplicationController
  def index
    @group = Group.find_by(user: current_user, id: params[:group_id])
    @operations = @group.operations.order(created_at: :desc)
  end

  def new
    @operation = Operation.new
    @groups = Group.all.where(user: current_user)
  end

  def create
    @operation = Operation.new(operation_params)
    @operation.user = current_user
    @group = Group.find_by(user: current_user, id: params[:group_id])
    @group.operations.push(@operation)
    if @operation.save
      redirect_to group_operations_path
    else
      render :new
    end
  end

  def destroy
    @group = Group.find_by(user: current_user, id: params[:group_id])
    @operation = @group.operations.find(params[:id])
    if @operation.destroy
      flash[:notice] = "Operation deleted successfully."
    else
      flash[:alert] = "Error deleting operation."
    end
    redirect_to group_operations_path(@group)
  end

  private

  def operation_params
    params.require(:operation).permit(:name, :amount)
  end
end
