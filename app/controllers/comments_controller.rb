class CommentsController < ApplicationController

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to user_path(@comment.post.user)
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :post_id)
  end
end