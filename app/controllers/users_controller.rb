class UsersController < ApplicationController
  before_action :authorize_user

  def index
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if current_user.update(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_path
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  
  private
 
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end