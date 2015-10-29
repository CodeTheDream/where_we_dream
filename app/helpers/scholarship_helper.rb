module ScholarshipHelper
  def full_date_time
    now, due, span, mobile = Time.now, @scholarship.deadline, '<span class="desktop-only">', '</span><span class="mobile-only">'
    day, month, date, d = %w[a b].map{ |x| "#{span}%#{x.upcase}#{mobile}%#{x}</span>" } + [due.day.ordinalize, distance_of_time_in_words(due, now)]
    distance, datetime = due > now ? "In " + d : d + " ago", due.strftime("#{day}, #{month} #{date} at %I:%M %P")
    "#{distance} (#{datetime})".html_safe
  end
  # These are two of the previous versions of this method. The method up here is the most compact I could get it
  # def full_date_time_2
  #   now = Time.now
  #   due = scholarship.deadline
  #   if due > now
  #     a = "In " + distance_of_time_in_words(due, now)
  #   else
  #     a = distance_of_time_in_words(due, now) + " ago"
  #   end
  #   a += " ("
  #   a += '<span class="desktop-only">' + due.strftime("%A") + '</span><span class="mobile-only">' + due.strftime("%a") + "</span>, "
  #   a += '<span class="desktop-only">' + due.strftime("%B") + '</span><span class="mobile-only">' + due.strftime("%b") + "</span> "
  #   a += due.strftime("#{due.day.ordinalize} at %I:%M %P") + ")"
  #   a.html_safe
  # end
  #
  # def full_date_time_3(scholarship = nil)
  #   scholarship = @scholarship unless scholarship
  #   now = Time.now
  #   due = scholarship.deadline
  #   if due > now
  #     a = "In " + distance_of_time_in_words(due, now)
  #   else
  #     a = distance_of_time_in_words(due, now) + " ago"
  #   end
  #   a + " (" + due.strftime("%A, %B #{due.day.ordinalize} at %I:%M %P") + ")"
  # end

  def link(resource)
    if resource.link
      link_to title(resource.name), resource.link, target: "_blank"
    else
      title(resource.name)
    end
  end

  def reward(scholarship = nil)
    scholarship = @scholarship unless scholarship
    if scholarship.full_ride
      "Full ride"
    else
      "$" + (number_with_delimiter scholarship.amount)
    end
  end

  def simple_date(scholarship)
    scholarship.deadline.strftime("%-m/%-d")
  end
end
