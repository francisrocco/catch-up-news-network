class FollowshipsController < ApplicationController

  before_action :authorize_user, only: [:follow]

  def follow
    user = User.find(params[:id])
    # Later we can just get rid of follow links for users you're already following
    if user.followed_by?(current_user)
      flash[:notice] = "You're already following this user!"
      redirect_to user_path(user)
    elsif user = current_user
      flash[:notice] = "You can't follow yourself, silly!"
      redirect_to user_path(user)
    else
      current_user.follow(user)
      flash[:notice] = "You just followed #{user.name}!"
      redirect_to user_path(user)
    end
  end

end