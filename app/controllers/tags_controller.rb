class TagsController < ApplicationController
	def index
	  if params[:search]
         @tag = Tag.find_by(name: params[:search])
        @posts = @tag.all_posts.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
   	 	render :show
	  end
	end

   def show
    # @posts = @tag.all_posts.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
    if params[:search]
      @tag = Tag.find(params[:search])
      @posts = @tag.all_posts.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
    else
   	 @tag = Tag.find(params[:id])
     @posts = @tag.all_posts.paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
    end
   end

end
