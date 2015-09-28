class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  def authenticate_user
    unless session[:user_id]
      redirect_to login_path
    end
  end

  def authenticate_admin
    unless session[:user_id] && admin_or_above?
      redirect_to login_path
    end
  end

  def authenticate_update
    #session[:user_id] is stored as a Fixnum. params[:id] is stored as a string
    unless session[:user_id].to_s == params[:id]
      redirect_to login_path
    end
  end

end
