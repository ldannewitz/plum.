class GroupsController < ApplicationController
  def create
    puts "in the groups create route"
    @group = Group.new(group_params)

    if @group.save
      # add_members
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

  def add_members
    # iterate over array of members passed from front and make new members
    p group_params['members']
  end

  def events
    group = Group.find(params[:id])
    @events = group.events
    render json: @events
  end

  private

  def group_params
    puts "in the group params"
    p params
    #   params.require(:group).permit(:name)
    # ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name])
    JSON.parse(request.body.read)
  end

end
