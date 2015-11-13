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
    ("<span class='likes"+hide+"'>"+likes+"</span>").html_safe
  end

  def dislikes(resource)
    if resource.disliked_by?(user_id)
      hide = ""
      dislikes = resource.dislikes
    else
      hide = " hide"
      dislikes = resource.dislikes + 1
    end
    dislikes = dislikes.to_s
    ("<span class='dislikes"+hide+"'>"+dislikes+"</span>").html_safe
  end

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
      %w[Admin Moderator Recruiter School\ Representative Student Teacher Parent Supporter]
    elsif admin?
      %w[Moderator Recruiter School\ Representative Student Teacher Parent Supporter School\ Representative]
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
    button_to "Delete", path, method: :delete, class: "button red-background", data: {confirm: "Are you sure you want to delete this #{thing}?"}
  end

  def self?
    @user.id == session[:user_id]
  end

  def not_self?
    !self?
  end

  def author
    unless @story.anonymous
      link_to @story.author, @story.user
    else
      "anonymous"
    end
  end

  def link(resource)
    if resource.link
      link_to title(resource.name), resource.link, target: "_blank"
    else
      title(resource.name)
    end
  end

  def lock(school = nil, mobile_only: false)
    school = school || @school
    school.public ? public_lock(mobile_only) : private_lock(mobile_only)
  end

  def public_lock(mobile_only = nil)
    visibility = mobile_only ? "mobile-only" : ""
    "<i title='Public' class='fa fa-unlock public #{visibility}'></i>".html_safe
  end

  def private_lock(mobile_only = nil)
    visibility = mobile_only ? "mobile-only" : ""
    "<i title='Private' class='fa fa-lock private #{visibility}'></i>".html_safe
  end

  def desktop_only(string = "")
    "<span class='desktop-only'>#{string}</span>".html_safe
  end

  def likes_bar(opinionable, flex: false, sides: false, bottom: false, mobile: false)
    bm = bottom ? mobile ? "bottom-margin-2" : "bottom-margin" : ""
    bm += " short-bar" if sides
    bm += " flex" if flex
    if opinionable.likes! == "no opinions"
      "<div class='no-opinions-bar #{bm}'></div>".html_safe
    else
      "<div class='dislikes-bar #{bm}'>
        <div class='likes-bar' width='#{opinionable.likes!}'></div>
      </div>".html_safe
    end
  end

  def anchor_tag(phrase, link = nil, tag: nil, top: true)
    top = top ? "<a href='#top' class='small'>Back to top</a>" : ""
    link = link || phrase
    if tag == false
      "<a name='#{link}'></a>".html_safe
    elsif tag
      "<a name='#{link}'></a><#{additional_tag}>#{phrase} #{top}</#{additional_tag}>".html_safe
    else
      "<a name='#{link}'></a><h3>#{phrase} #{top}</h3>".html_safe
    end
  end

  def anchor_link(phrase, link = nil)
    if link
      "<li><a href='##{link}' class='anchor-link'>#{phrase}</a></li>".html_safe
    else
      "<li><a href='##{phrase}' class='anchor-link'>#{phrase}</a><br/></li>".html_safe
    end
  end

  def deadline_icon(deadline, size = nil)
    unless deadline.class == Fixnum
      num = if deadline > Time.now # future
        case deadline - Time.now
        when 0..1.month; 1
        when 1.month..2.months; 2
        when 2.months..3.months; 3
        when 3.months..4.months; 4
        when 4.months..5.months; 5
        else 6
        end
      else # past
        7
      end
    end
    image_tag "deadline_icon_#{num}.gif", style: "height:#{size || 10}px;"
  end
end
