module SchoolsHelper
  def color_paragraph(answer)
    css_array = {true => "bg-good", false => "bg-bad", nil => "bg-neutral"}
    css_class = css_array[answer]
    "<p class='rule #{css_class}'>".html_safe
  end

  def lock(school = nil, mobile_only: false)
    school = school || @school
    school.public ? public_lock(mobile_only) : private_lock(mobile_only)
  end

  def private_lock(mobile_only = nil)
    visibility = mobile_only ? "mobile-only" : ""
    "<i title='Private' class='fa fa-lock private #{visibility}'></i>".html_safe
  end

  def public_lock(mobile_only = nil)
    visibility = mobile_only ? "mobile-only" : ""
    "<i title='Public' class='fa fa-unlock public #{visibility}'></i>".html_safe
  end
end
