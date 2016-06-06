class GroupsController < ApplicationController
  def create
    # @group = Group.new(group_params)

    # got this from active_model_serializers GitHub

    # pull out members
    puts params
    # return 200
    # Group.create(group_params) # or .new?

    ## What do we send back here???

    # if @group.save
    #   redirect_to @group
    # else
    #   render 'new'
    # end
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

  # make this a MODEL METHOD instead
  def add_members
    @group = Group.find(params[:id])
    # depends what we get from the front end?
    @group.members = []
    # again, what are we sending back?
    # or where do we route?
  end

  def events
    group = Group.find(params[:id])
    @events = group.events
    render json: @events
  end

  private

  def group_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name], [:members])
  end

  # def group_params
  #   params.require(:group).permit(:name)
  # end
end
