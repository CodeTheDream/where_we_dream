module Opinionable
  def type
    self.class.to_s
  end

  def liked_by?(user)
    return false unless [User, Fixnum].include?(user.class)
    user_id = user.class == User ? user.id : user
    # opinions should already be loaded
    # use find instead of where to avoid triggering an sql query
    # opinions.where(user_id: user_id, value: true).any?
    opinions.find { |x| x.user_id == user_id && x.value }.present?
  end

  def disliked_by?(user)
    return false unless [User, Fixnum].include?(user.class)
    user_id = user.class == User ? user.id : user
    # opinions should already be loaded
    # use find instead of where to avoid triggering an sql query
    # opinions.where(user_id: user_id, value: false).any?
    opinions.find { |x| x.user_id == user_id && x.value == false }.present?
  end

  def likes
    opinions.select(&:value).size
  end

  def dislikes
    opinions.select { |x| x.value == false }.size
  end

  # returns percentage of likes from total opinions
  def likes!
    total = opinions.size
    return 'no opinions' if total == 0
    (likes.to_f / total.to_f) * 100
  end
end
