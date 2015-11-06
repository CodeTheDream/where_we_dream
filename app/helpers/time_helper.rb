module TimeHelper
  def created_at(thing)
    distance_of_time_in_words(thing.created_at, Time.now) + " ago"
  end

  def dateyear(time)
    time.strftime("%-m/%-d/%Y")
  end

  def full_date_time
    now, due, span, mobile = Time.now, @scholarship.deadline, '<span class="desktop-only">', '</span><span class="mobile-only">'
    day, month, date, d = %w[a b].map{ |x| "#{span}%#{x.upcase}#{mobile}%#{x}</span>" } + [due.day.ordinalize, distance_of_time_in_words(due, now)]
    distance, datetime = due > now ? "In " + d : d + " ago", due.strftime("#{day}, #{month} #{date} at %I:%M %P")
    "#{distance} (#{datetime})".html_safe
  end

  def simple_date(time)
    time.strftime("%-m/%-d")
  end

  def updated_and_created_at(thing)
    # t = time, d = distance, s = timestamp, c = create, u = update
    t_of_c, t_of_u, d_of_c, d_of_u = thing.created_at, thing.updated_at, created_at(thing), updated_at(thing)
    s_of_c, published = dateyear(t_of_c), "Published #{d_of_c}"
    c_span, u_span = "<span title='#{s_of_c}'>#{published}</span>", "<span title='#{published} on #{s_of_c}'>Updated #{d_of_u}</span>"
    ( t_of_c == t_of_u ? c_span : u_span ).html_safe
  end

  def updated_at(thing)
    time_ago_in_words(thing.updated_at) + " ago"
  end
end
