module ScholarshipHelper
  def full_date_time(scholarship = nil)
    scholarship = @scholarship unless scholarship
    now = Time.now
    due = scholarship.deadline
    if due > now
      a = "In " + distance_of_time_in_words(due, now)
    else
      a = distance_of_time_in_words(due, now) + " ago"
    end
    a + " (" + due.strftime("%A, %B #{due.day.ordinalize} at %I:%M %P") + ")"
  end

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
    scholarship.deadline.strftime("%m/%d")
  end
end
