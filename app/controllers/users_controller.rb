class UsersController < ApplicationController
  before_action :set_user, only: [:show, :groups, :events, :bills]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/:id
  def show
    render json: @user
  end

  # GET /users/:id/groups
  def groups
    @groups = @user.groups
    render json: @groups
  end

  # GET /users/:id/events
  def events
    @events = @user.events
    render json: @events
  end

  def bills
    @user.events.each do |event|
      event.expired?
    end
    @bills = @user.bills.where(satisfied?: false)
    render json: @bills
  end

  # POST /users/:id/events
  def new_event
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    JSON.parse(request.body.read)
  #   # ActiveModelSerializers::Deserialization.jsonapi_parse(params[:user], only: [:first_name, :last_name, :email, :password, :phone])
  #   # p params.fetch(:user, {}).permit(:first_name, :last_name, :name, :email, :password, :phone)
  #   params.require(:user).permit(:first_name, :last_name, :name, :email, :password, :phone)
  #   # params.require(:user).print(:first_name, :last_name, :name, :email, :password, :phone)
  end

  def event_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params.as_json, only: [:name, :start_date, :end_date, :settled?, :group_id, :total] )

    # ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [ ['data']['attributes']['name'], ['data']['attributes']['start_date'].DateTime, ['data']['attributes']['end_date'].DateTime, ['data']['attributes']['settled?'], ['data']['attributes']['group_id'].to_i, ['data']['attributes']['total'].to_i ])
  end

  # def event_params
  #   params.require(:event).permit(:name, :start_date, :end_date, :settled?, :group_id, :total)
  # end

end
