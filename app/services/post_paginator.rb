class PostPaginator 
  
  def self.all_posts(current_user, params)
  	Post.all_posts_for_index(current_user).paginate(:page => params[:page]|| 1, :per_page => 5).order('created_at DESC')
  end

end