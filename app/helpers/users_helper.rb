module UsersHelper
  def user_id
    session[:user_id]
  end

  alias_method :logged_in?, :user_id

  def modder_or_below_of?(user)
    %w[Moderator Student Teacher School Supporter School\ Representative].include?(user.type)
  end

  def modder_or_above?
    %w[Moderator Admin God].include? user_type
  end

  def recruiter_or_above?
    %w[Recruiter Admin God].include? user_type
  end

  def admin_or_above?
    %w[Admin God].include? user_type
  end

  def team_member?
    %w[Recruiter Moderator Admin God].include? user_type
  end

  def admin?
    user_type == 'Admin'
  end

  def god?
    user_type == 'God'
  end

  def user_types
    if god?
      %w[God Admin Moderator Recruiter School\ Representative Student Teacher Parent Supporter]
    elsif admin?
      %w[Moderator Recruiter School\ Representative Student Teacher Parent Supporter School\ Representative]
    else
      %w[Student Teacher Parent Supporter]
    end
  end

  def user_type
    session[:user_type]
  end

  def user
    User.find(session[:user_id])
  end

  def self?
    @user.id == session[:user_id]
  end

  def not_self?
    !self?
  end


end
