class PagesController < ApplicationController
  helper_method :sort_column

  def home
    User.any? ? () : (session[:user_id], session[:user_type] = nil)
    @page = "home"
    @user = User.find(user_id) rescue nil
  end

  def schools
    School.where(name: nil).destroy_all
    @schools = School.search(params[:search]).order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  def students
    @users = User.students.search(params[:search]).order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  def scholarships
    @scholarships = Scholarship.search(params[:search]).order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  def about
    @team_members = User.where.not(team_contribution: nil)
  end

  def wait
    redirect_to root_path, notice: "Account already activated" if logged_in?
  end

  private def sort_column
    if params[:action] == "students"
      %w[first_name last_name].include?(params[:sort]) ? params[:sort] : "first_name"
    elsif params[:action] == "schools"
      %w[name rating public city complete].include?(params[:sort]) ? params[:sort] : "name"
    else
      %w[name amount deadline].include?(params[:sort]) ? params[:sort] : "name"
    end
  end
end
