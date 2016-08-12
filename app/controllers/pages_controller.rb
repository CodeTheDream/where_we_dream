class PagesController < ApplicationController
  helper_method :sort_column

  def home
    User.any? ? () : (session[:user_id], session[:user_type] = nil)
    @page = "home"
    @user = User.find(user_id) rescue nil
    @recent_schools = School.where.not(name: nil).order(updated_at: :desc).limit(3)
    @recent_scholarships = Scholarship.order(updated_at: :desc).limit(3)
    @recent_states = State.order(updated_at: :desc).limit(3)
    @recent_stories = Story.order(updated_at: :desc).limit(3)
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

  def faqs
    # puppy, kitty, bunny long urls (respectively)
    # 'http://latinlink.usmediaconsulting.com/wp-content/uploads/2014/05/8-pets.jpg'
    # 'http://41.media.tumblr.com/tumblr_lr8cybBBXS1qdifw1o1_500.jpg'
    # 'http://www.rabbit.org/adoption/bunny.jpg'

    @image = {
      puppy: 'http://goo.gl/X0bHPB',
      kitty: 'http://goo.gl/fzAkNP',
      bunny: 'http://goo.gl/Z9zBY'
    }
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
