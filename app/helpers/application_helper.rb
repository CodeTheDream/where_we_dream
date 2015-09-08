module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    css_class = column == sort_column ? "#{direction}" : nil
    link_to title, params.merge(sort: column, direction: direction), {class: css_class, style: 'text-decoration:none;'}
  end
end
