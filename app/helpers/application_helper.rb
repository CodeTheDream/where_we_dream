module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? "#{direction}" : nil
    link_to title, params.merge(sort: column, direction: direction), {class: css_class, style: 'text-decoration:none;'}
  end

  def likable(comment)
    comment.liked? ? "fa fa-thumbs-up opinion liked" : "fa fa-thumbs-up opinion"
    button_to make_opinion_path, class: css_class, remote: true
  end

  def dislikable

  end

  def logged_in?
    session[:user_id]
  end

  def admin_or_above?
    %w[Admin God].include?(session[:user_type])
  end

  def admin?
    user_type == 'Admin'
  end

  def god?
    user_type == 'God'
  end

  def user_types
    if god?
      %w[God Admin Moderator Recruiter Student Teacher School]
    elsif admin?
      %w[Moderator Recruiter Student Teacher School]
    else
      %w[Student Teacher Parent]
    end
  end

  def user_type
    session[:user_type]
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def created_at(comment)
    distance_of_time_in_words(comment.created_at!, Time.now) + " ago"
  end

  def user
    User.find(session[:user_id])
  end

  def owner?(comment)
    comment.user.id == session[:user_id]
  end
end
