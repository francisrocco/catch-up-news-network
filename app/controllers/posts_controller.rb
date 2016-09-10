class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :authorize_user, only: [:index]

  def new
    @post = Post.new
  end

  def index
    # not sure yet how to implement
    # @posts = Post.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
    @posts_by_user = Post.get_user_posts_by_following(current_user)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @creator = current_user
    if @post.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end
  

  def edit
  end

  def update
  end


  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, tag_ids: [], :tags_attributes => [:name])
  end

end
