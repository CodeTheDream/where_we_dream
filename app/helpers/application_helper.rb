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
      %w[Admin Moderator Recruiter Student Teacher School Supporter school_representative].map &:titleize
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

  def color_paragraph(answer)
    css_array = {true => "bg-good", false => "bg-bad", nil => "bg-neutral"}
    css_class = css_array[answer]
    "<p class='rule #{css_class}'>".html_safe
  end

  def notice_helper
    style = @page == 'home' ?  ' style="position:relative"' : nil
    "<p id='notice'#{style}>#{notice}</p>".html_safe
  end

  def complex_md_parser(text)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autoliink: true,
      strikethrough: true,
      underline: true,
      highlight: true,
      superscript: true,
      disable_indented_code_blocks: true,
      space_after_headers: true
    )
    markdown.render(text).html_safe
  end

  def simple_md_parser(text)
    markdown = Redcarpet::Markdown.new(RenderWithoutWrap.new(
      hard_wrap: true,
      disable_indented_code_blocks: true,
      space_after_headers: true,
      safe_links_only: true,
      autolink: true,
      escape_html: true,
      no_images: true,
    ))
    text = pound_filter text
    text = asterisk_filter text
    text = dash_filter text
    # text = number_filter text # ordered lists are still possible...Not really a big deal.
    markdown.render(text).html_safe
  end

  def pound_filter text
    text.gsub /^#/, '\#'
  end

  def asterisk_filter text
    text.gsub /^\*/, '\*'
  end

  def dash_filter text
    text.gsub /^-/, '\-'
  end

  # def number_filter text
  #   if text[/^\d./].present?
  #     text[/^\d./].each do |match|
  #       escape = '\\' + match
  #       text.gsub match, escape
  #     end
  #   end
  # end

  def back
    link_to '<i class="fa fa-arrow-left"></i> Back'.html_safe, :back
  end

  def delatable?(comment)
    user = comment.user.type
    comment.owner?(user_id) || (modder_or_above? && modder_or_below_of?(comment.user))
  end

  def pluralize_without_count(count, noun, text = nil)
    if count != 0
      count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
    end
  end

  def simple_pluralize count, singular, plural=nil
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end
end
