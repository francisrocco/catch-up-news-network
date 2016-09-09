class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.all_posts.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
  end

end
