module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_direction = direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? "#{css_direction}" : nil
    link_to title, params.merge(sort: column, direction: direction), {class: css_class}
  end

  def thumbs_up(resource)
    resource.liked_by?(user_id) ? liked = " liked": liked = ""
    ("<i class='fa fa-thumbs-up opinion" + liked + "'></i>").html_safe
  end

  def thumbs_down(resource)
    resource.disliked_by?(user_id) ? disliked = " disliked": disliked = ""
    ("<i class='fa fa-thumbs-down opinion" + disliked + "'></i>").html_safe
  end

  def likes(resource)
    if resource.liked_by?(user_id)
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

  def modder_or_below_of?(user)
    %w[Moderator Student Teacher School Supporter school_representative].map(&:titleize).include?(user.type)
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

  def admin?
    user_type == 'Admin'
  end

  def god?
    user_type == 'God'
  end

  def user_types
    if god?
      %w[God Admin Moderator Recruiter Student Teacher School Supporter school_representative].map &:titleize
    elsif admin?
      %w[Moderator Recruiter Student Teacher School Supporter school_representative].map &:titleize
    else
      %w[Student Teacher Parent Supporter]
    end
  end

  def user_type
    session[:user_type]
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def user
    User.find(session[:user_id])
  end

  def copywrite_year
    Date.today.year == 2015 ? 2015 : "2015-#{today}"
  end

  def color_paragraph(answer)
    css_array = {true => "bg-good", false => "bg-bad", nil => "bg-neutral"}
    css_class = css_array[answer]
    "<p class='rule #{css_class}'>".html_safe
  end

  def notice_helper
    style = @page == 'home' ?  ' style="position:relative"' : nil
    "<p id='notice'#{style}>#{notice}</p>".html_safe
  end

  def back
    link_to '<span class="button dark-blue-background submit"><i class="fa fa-arrow-left"></i> Back<span>'.html_safe, :back
  end

  def simple_pluralize(count, singular, plural = nil)
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end

  def destroy(resource)
    thing = resource.class.to_s.downcase
    path = "/admin/#{thing}s/#{resource.id}"
    button_to "Delete", path, method: :delete, class: "button red-background", data: {confirm: "Are you sure to delete this #{thing}?"}
  end

  def not_self?
    @user.id != session[:user_id]
  end

  def author
    unless @story.anonymous
      link_to @story.author, user
    else
      "anonymous"
    end
  end

  def updated_at(thing)
    distance_of_time_in_words(thing.updated_at, Time.now) + " ago"
  end
end
