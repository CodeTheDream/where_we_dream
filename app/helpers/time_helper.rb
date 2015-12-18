module TimeHelper
  def created_at(thing)
    distance_of_time_in_words(thing.created_at, Time.now) + " ago"
  end

  def dateyear(time)
    time.strftime("%-m/%-d/%Y")
  end

  def full_date_time
    due, d = @scholarship.deadline, time_in_words(@scholarship.deadline)
    day, month, date, distance = desktop_mobile("%A"=>"%a", "%B"=>"%b", due.day.ordinalize => due.day, d => d.abbreviate)
    datetime = due.strftime("#{day}, #{month} #{date} at %I:%M %P")
    "#{distance} (#{datetime})".html_safe
  end

  def recently_created?(resource, words: nil)
    just_created = resource.created_at == resource.updated_at

    if words
      just_created ? "created" : "updated"
    else
      just_created
    end
  end

  def simple_date(time)
    time.strftime("%-m/%-d")
  end

  def time(resource)
    if recently_created?(resource)
      "added #{time_in_words(resource.updated_at)}"
    else
      "updated #{time_in_words(resource.updated_at)}"
    end
  end

  def time_in_words(time)
    d = time_ago_in_words(time)
    time > Time.now ? "In " + d : d + " ago"
  end

  def updated_and_created_at(thing)
    # t = time, d = distance, s = timestamp, c = create, u = update
    t_of_c, t_of_u, d_of_c, d_of_u = thing.created_at, thing.updated_at, created_at(thing), updated_at(thing)
    s_of_c, published = dateyear(t_of_c), "Published #{d_of_c}"
    c_span, u_span = "<span title='#{s_of_c}'>#{published}</span>", "<span title='#{published} on #{s_of_c}'>Updated #{d_of_u}</span>"
    ( t_of_c == t_of_u ? c_span : u_span ).html_safe
  end

  def updated_at(thing)
    time_in_words(thing.updated_at)
  end
end
