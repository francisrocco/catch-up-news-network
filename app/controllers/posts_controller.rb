class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:index, :show, :dashboard]
  before_action :set_limit_vote, only: [:up_vote, :down_vote]

  def new
    @post = Post.new
    3.times do
      @post.tags.build
    end
  end

  def index
    @all_posts = PostPaginator.all_posts(current_user, params)  
  end


  def dashboard
    @current_user_posts = PostPaginator.get_user_posts(current_user, params)
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @creator = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end


  def edit
    unless @post.user == current_user
      redirect_to posts_path
    end

  end

  def update
      respond_to do |format|
      @post.tags.destroy_all
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @post.destroy
    redirect_to user_path(@post.user)
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :tags_attributes => [:name, :id])
  end


end
