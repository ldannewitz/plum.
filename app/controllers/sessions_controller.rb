class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def login
    @user = User.find_by(email: session_params[:email])
    p "================="
    p params
    p "======initial params====="
    if @user && @user.authenticate(session_params[:password])
      p "++++++++++++++++++"
      p params
      p "+++++++if statement true+++++++++++"
      session[:user_id] = @user.id
      render json: @user, status: :created, location: @user
    else
      @error = "Invalid email adress or password"
      render json: @error, status: :unprocessable_entity
      p "helloooopooooooooooo"
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
