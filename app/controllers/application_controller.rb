class ApplicationController < ActionController::Base

  # prevent csrf attacks:
  protect_from_forgery with: :exception

  # make these methods available to views:
  helper_method :current_user, :logged_in?

  def current_user
    # "||=" is, "if @current_user isn't already set" 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # "!!" converts the "current_user" variable to a boolean (exists or doesn't)
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

end
