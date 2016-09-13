class VotesController < ApplicationController
  before_action :set_limit_vote

  
  def up_vote
    if @vote
      @vote.update_attribute(:value, 1)
        respond_to do |format|
          format.js 
        end
    else
      @vote = current_user.votes.create(value: 1, post: @post)
      @vote.save
        respond_to do |format| 
          format.html do
            if @vote.valid?
              redirect_to :back
            end
          end
          format.js
        end
    end
  end
 
  def down_vote
    if @vote
      @vote.update_attribute(:value, -1)
        respond_to do |format|
          format.js 
        end
    else
      @vote = current_user.votes.create(value: -1, post: @post)
      @vote.save
        respond_to do |format| 
          format.html do
            if @vote.valid?
              redirect_to :back
            end
          end
          format.js
        end
    end
  end

  private

  
  def set_limit_vote
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: current_user.id).first
    #please did not delete the second line && create votes. 
  end



end 