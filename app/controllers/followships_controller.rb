class FollowshipsController < ApplicationController

  def follow
    user = User.find(params[:id])
    # Later we can just get rid of follow links for users you're already following
    if user.followed_by?(current_user)
      flash[:notice] = "You're already following this user!"
      redirect_to user_path(user)
    else
      current_user.follow(user)
      flash[:notice] = "You just followed #{user.name}!"
      redirect_to user_path(user)
    end
  end

end