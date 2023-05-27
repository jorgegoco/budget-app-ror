class OperationsController < ApplicationController
  before_action :set_instance_variables

  def index
    @operations = @group.operations.order(created_at: :desc)
  end

  def new
    @operation = Operation.new
  end

  def create
    @operation = Operation.new(operation_params)
    @operation.user = current_user
    @group.operations.push(@operation)
    if @operation.save
      redirect_to group_operations_path
    else
      render :new
    end
  end

  def destroy
    @operation.destroy
    redirect_to group_operations_path(@group) 
  end

  private

  def set_instance_variables
    @group = Group.find_by(user: current_user, id: params[:group_id])
    @groups = Group.all.where(user: current_user)
    @operation = Operation.find(params[:id]) if params[:id]
  end

  def operation_params
    params.require(:operation).permit(:name, :amount)
  end
end
