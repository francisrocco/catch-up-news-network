class FollowshipsController < ApplicationController

  def follow
    # binding.pry
    new_following = User.find(params[:id])
    new_relationship = Followship.new(follower_id: current_user.id, following_id: new_following.id)
    if new_relationship.save
      flash[:notice] = "You just followed #{new_following.name}!"
      redirect_to user_path(new_following)
    else
      # Later we can just get rid of follow links for users you're already following
      flash[:notice] = "You're already following this user!"
      redirect_to user_path(new_following)
    end
  end

end