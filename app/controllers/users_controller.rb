class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :authorize_user, only: [:dashboard, :edit, :update, :show]
  before_action :update_user_params, only: [:update]

  def index
    @users = User.all.paginate(:page => params[:page]|| 1, :per_page => 20)
  end

  def edit
  end

  def update
    if current_user.authenticate(params[:user][:original_password])

      if current_user.update(user_params)
        flash[:notice] = "User information updated"
        redirect_to user_path(current_user)
      else
        flash[:error] = "Authenticate yourself before you wreck yourself."
        render "edit"
      end

    else
        flash[:error] = "Authenticate yourself before you wreck yourself."
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

    def update_user_params
    params.require(:user).permit(:name, :email, :password, :original_password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
