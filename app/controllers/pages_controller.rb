class PagesController < ApplicationController
  helper_method :sort_column
  def home
    User.any? ? () : (session[:user_id], session[:user_type] = nil)
    @page = "home"
  end

  def schools
    @schools = School.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  def profile
    @user = User.find(session[:user_id])
  end

  private def sort_column
    %w[name rating public city complete].include?(params[:sort]) ? params[:sort] : "name"
  end
end
