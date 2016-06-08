class GroupsController < ApplicationController

  def create
    @user = User.find(params[:userId])
    @group = Group.new(group_params)
    # @group = @user.groups.new(name: group_params[:name])
    if @group.save
      @group.add_members(params[:members], params[:userId])
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def show
    @group = Group.find(params[:id])
    render json: @group
  end

  def members
    group = Group.find(params[:id])
    @members = group.members
    render json: @members
  end

  def events
    group = Group.find(params[:id])
    @events = group.events
    render json: @events
  end

  private

  def group_params
    params.permit(:name)
  end

end
