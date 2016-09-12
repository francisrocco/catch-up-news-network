class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :authorize_user, :logged_in?

	def home
		if logged_in?
			redirect_to posts_path
		else
			render 'sessions/new'
		end
	end

	def current_user 
	  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
    

	def logged_in?
	  !!current_user
	end

	def authorize_user
	  if !logged_in?
  		flash[:notice] = "You must be logged in to view this page! Cool kids only! 😍"
	    redirect_to login_path
	  end
	end
	

end
