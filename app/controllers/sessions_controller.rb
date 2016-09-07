class SessionsController < ApplicationController

  def new
    
  end

  def welcome

  end

  def create
    user = User.find_by(username: params[:username])
    if user  && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/index'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/index'
  end


end