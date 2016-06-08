class UsersController < ApplicationController
  before_action :set_user, only: [:show, :groups, :events, :bills]
  before_action :authenticate

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/:id
  def show
    @user.events.each do |event|
      event.expired?
    end
    render json: @user
  end

  # GET /users/:id/groups
  def groups
    @user.events.each do |event|
      event.expired?
    end
    @groups = @user.groups
    render json: @groups
  end

  # GET /users/:id/events
  def events
    @user.events.each do |event|
      event.expired?
    end
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
    params.permit(:name, :start_date, :end_date, :settled?, :group_id, :total)
  end

  protected

  def authenticate
    p token
  end

  def authenticate_token
    User.find_by(auth_token: token)
  end

  # def authenticate_preview_realm
  #   authenticate_or_request_with_http_token('Preview') do |token, options|
  #     User.find_by(auth_token: token)
  #   end
  # end

  # def authenticate_banana_realm
  #   authenticate_token || render_unauthorized('Banana')
  # end

  def render_unauthorized(realm=nil)
    if realm
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
    end
    render json: 'Bad credentials', status: 401
  end
end
