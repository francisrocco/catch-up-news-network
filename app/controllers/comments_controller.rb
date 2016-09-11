class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      flash[:notice] = "You can't post that!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :post_id)
  end
end