class PagesController < ApplicationController
  def home
    User.any? ? () : (session[:user_id], session[:user_type] = nil)
    @page = "home"
  end

  def schools
    @schools = School.search(params[:search]).order(sort_column + " " + sort_direction)
  end
end
