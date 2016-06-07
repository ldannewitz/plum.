class SessionsController < ApplicationController

  def login
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      @user.events.each do |event|
        event.expired?
      end
      render json: @user, status: :created, location: @user
    else
      @error = "Invalid email adress or password"
      render json: @error, status: :unprocessable_entity
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
