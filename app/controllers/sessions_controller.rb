class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def welcome

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_path
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
