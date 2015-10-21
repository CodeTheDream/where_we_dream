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
    @states = School.states
  end

  def students
    @users = User.students.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  def about
    @team_members = User.where.not(team_contribution: nil)
  end

  def contact

  end

  def wait
  end

  private def sort_column
    if params[:action] == "students"
      %w[first_name last_name].include?(params[:sort]) ? params[:sort] : "first_name"
    else
      %w[name rating public city complete].include?(params[:sort]) ? params[:sort] : "name"
    end
  end
end
