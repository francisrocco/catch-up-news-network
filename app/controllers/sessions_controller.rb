class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def welcome

  end

  def create
    user = User.find_by(email: login_params[:email])
    binding.pry
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private
    def login_params
      params.require(:user).permit(:email, :password)
    end

end
