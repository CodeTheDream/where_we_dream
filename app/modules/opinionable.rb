module Opinionable
  def type
    self.class.to_s
  end

  def liked_by?(user)
    return false unless [User, Fixnum].include?(user.class)
    user_id = user.class == User ? user.id : user
    opinions.where(user_id: user_id, value: true).any?
  end

  def disliked_by?(user)
    return false unless [User, Fixnum].include?(user.class)
    user_id = user.class == User ? user.id : user
    opinions.where(user_id: user_id, value: false).any?
  end

  def likes
    opinions.where(value: true).count
  end

  def dislikes
    opinions.where(value: false).count
  end
end
