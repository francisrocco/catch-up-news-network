class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    byebug
    @post = Post.new(post_params)
    @post.user_id = current_user.id
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
