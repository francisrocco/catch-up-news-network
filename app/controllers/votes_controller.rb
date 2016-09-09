class VotesController < ApplicationController
  before_action :set_post


  def up_vote
    if @vote
      @vote.update_attribute(:value, 1)
    else
      @vote = current_user.votes.create(value: 1, post: @post)
    end
    redirect_to :back
  end
  

  def down_vote
    if @vote
      @vote.update_attribute(:value, -1)
    else
      @vote = current_user.votes.create(value: -1, post: @post)
    end
    redirect_to :back
  end
 

  private

  def set_post
    @post = Post.find(params[:post_id])
  end


end 