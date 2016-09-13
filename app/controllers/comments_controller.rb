class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast 'comments',
        comment: @comment.message,
        datetime: @comment.datetime,
        user: @comment.user.name,
        user_id: @comment.user.id
      head :ok
    # else
    #   flash[:notice] = "You can't post that!"
    #   render 'post/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :post_id)
  end
end