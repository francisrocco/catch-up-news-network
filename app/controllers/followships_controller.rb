class FollowshipsController < ApplicationController

  before_action :authorize_user, only: [:follow]

  def follow
    user = User.find(params[:id])

    current_user.follow(user)
    respond_to do |f|
      f.js
      f.html { redirect_to root_path }
    end
  end

end
