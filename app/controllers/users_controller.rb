class UserController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def groups
    user = User.find(params[:id])
    @groups = user.groups
    render json: @groups
  end

  def events
    user = User.find(params[:id])
    @events = user.events
    render json: @events
  end

  def new_event
    @event = Event.new(event_params)

    ## What do we send back here???

    # if @event.save
    #   redirect_to @event
    # else
    #   render 'new'
    # end
  end

  def create
    @user = User.new(user_params)


    ## What do we send back here???

    # if @user.save
    #   session[:user_id] = @user.id
    #   redirect_to @user
    # else
    #   render 'new'
    # end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone)
  end

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :settled?, :group_id, :total)
  end

end
