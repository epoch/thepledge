class UsersController < ApplicationController
  before_action :check_if_admin, :only => [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def signup_login
    session[:destination] ||= request.env["HTTP_REFERER"]
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_if_admin
    redirect_to(root_path) unless @current_user.present? && @current_user.is_admin?
  end

end
