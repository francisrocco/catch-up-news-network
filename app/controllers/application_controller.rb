class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :authorize_user, :logged_in?

	def home
	  render '/index'
	end

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
	  !!current_user
	end

	def authorize_user
	  if !logged_in?
	   redirect_to '/index'
	  end
	end


end
