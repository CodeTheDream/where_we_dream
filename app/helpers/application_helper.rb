module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_direction = direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? "#{css_direction}" : nil
    link_to title, params.merge(sort: column, direction: direction), {class: css_class}
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def copywrite_year
    Date.today.year == 2015 ? 2015 : "2015-#{Date.today.year}"
  end

  def simple_pluralize(count, singular, plural = nil)
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end

  def destroy(resource)
    thing = resource.class.to_s.downcase
    button_to 'Delete', resource, method: :delete, class: 'red-button', data: { confirm: "Are you sure you want to delete this #{thing}?" }
  end

  def link(resource)
    if State === resource
      css_class = resource.in_state_css + " small-mobile"
      link_to resource.abbreviation, admin_state_path(resource), class: css_class, title: resource.name
    elsif resource.link
      link_to title(resource.name), resource.link, target: "_blank"
    else
      title(resource.name)
    end
  end

  def oauth_path(provider)
    "/auth/#{provider}"
  end
end
