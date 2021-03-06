class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  private
  def authenticate
    if session[:user_id].present?
      @current_user = User.find_by :id => session[:user_id]
    end
    session[:user_id] = nil unless @current_user.present?
  end

  def logged_in?
    unless @current_user.present?
      session[:destination] = request.env["PATH_INFO"]
      redirect_to(signup_login_path)
    end
  end
end