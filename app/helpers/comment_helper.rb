module CommentHelper
  def created_at(comment)
    distance_of_time_in_words(comment.created_at, Time.now) + " ago"
  end

  def delatable?(comment)
    user = comment.user.type
    comment.owner?(user_id) || (modder_or_above? && modder_or_below_of?(comment.user))
  end

  def owner?(comment)
    comment.user.id == session[:user_id]
  end
end
