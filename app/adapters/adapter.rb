module Adapter
  class AdapterWrapper
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
end