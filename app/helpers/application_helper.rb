module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_direction = direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? "blue-link #{css_direction}" : "blue-link"
    link_to title, params.merge(sort: column, direction: direction), {class: css_class}
  end

  def thumbs_up(resource)
    resource.liked?(user_id) ? liked = " liked": liked = ""
    ("<i class='fa fa-thumbs-up opinion" + liked + "'></i>").html_safe
  end

  def thumbs_down(resource)
    resource.disliked?(user_id) ? disliked = " disliked": disliked = ""
    ("<i class='fa fa-thumbs-down opinion" + disliked + "'></i>").html_safe
  end

  def likes(resource)
    if resource.liked?(user_id)
      hide = ""
      likes = resource.likes
    else
      hide = " hide"
      likes = resource.likes + 1
    end
    likes = likes.to_s
    ("<span class='likes"+hide+"'>"+likes+"   </span>").html_safe
  end

  def user_id
    session[:user_id]
  end

  alias_method :logged_in?, :user_id

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
    distance_of_time_in_words(comment.created_at, Time.now) + " ago"
  end

  def user
    User.find(session[:user_id])
  end

  def owner?(comment)
    comment.user.id == session[:user_id]
  end

  def copywrite_year
    Date.today.year == 2015 ? 2015 : "2015-#{today}"
  end
end
