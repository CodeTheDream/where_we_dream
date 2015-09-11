module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? "#{direction}" : nil
    link_to title, params.merge(sort: column, direction: direction), {class: css_class, style: 'text-decoration:none;'}
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
end
