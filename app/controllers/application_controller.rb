class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :authorize_user, :logged_in?, :link_to_blank

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

	def link_to_blank(name = nil, options = nil, html_options = nil, &block)
  target_blank = {target: "_blank"}
  if block_given?
    options ||= {}
    options = options.merge(target_blank)
  else
    html_options ||= {}
    html_options = html_options.merge(target_blank)
  end
  link_to(name, options, html_options, &block)
end

end
