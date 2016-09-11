class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:index, :show]


  def new
    @post = Post.new
  end

  def index
    # @posts = Post.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
    @posts_by_user = Post.get_user_posts_by_following(current_user).paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
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
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, tag_ids: [], :tags_attributes => [:name])
  end

end
