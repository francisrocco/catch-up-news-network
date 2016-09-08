class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.paginate(:page => params[:page]|| 1, :per_page => 5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
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
    params.require(:post).permit(:title, :link)
  end

end
