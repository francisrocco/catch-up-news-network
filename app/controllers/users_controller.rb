class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :authorize_user, only: [:dashboard, :edit, :update, :show]

  def index
    @users = User.all
  end

  def edit
  end
  
  def update
    if current_user.update(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_path
    else
      render "edit"
    end
  end

  def show
  end

  def dashboard
  end
  
  private
 
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end