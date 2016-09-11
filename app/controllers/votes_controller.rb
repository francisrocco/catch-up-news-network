class VotesController < ApplicationController
  before_action :set_limit_vote


  def up_vote
    if @vote
      @vote.update_attribute(:value, 1)
      flash[:notice] = "Successfully upvoted."
        respond_to do |format| 
        format.html {redirect_to :back}
        format.js
    end
    else
      @vote = current_user.votes.create(value: 1, post: @post)
        flash[:notice] = "Successfully upvoted."
        respond_to do |format| 
        format.html {redirect_to :back}
        format.js
      end
    end
    redirect_to :back
  end
 

  def down_vote
    if @vote
      @vote.update_attribute(:value, -1)
              flash[:notice] = "Successfully downvoted."

      respond_to do |format| 
        format.html {redirect_to :back, notice: "You voted!"}
        format.js
      end
    else
      @vote = current_user.votes.create(value: -1, post: @post)
                    flash[:notice] = "Successfully downvoted."

      respond_to do |format| 
        format.html {redirect_to :back, notice: "You voted!"}
        format.js
      end
    end
    redirect_to :back
  end
 

  private
  def set_limit_vote
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: current_user.id).first
    #please did not delete the second line && create votes. 
  end



end 