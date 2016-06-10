class GroupsController < ApplicationController

  def create
    p params
    @user = User.find(params[:user_id])
    params[:user_id] = @user.id
    @group = Group.new(group_params)
    @group.add_members(params[:members], @user.id)
    # @group = @user.groups.new(name: group_params[:name])
    if @group.save
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
