class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :opinions, as: :opinionable, dependent: :destroy

  validates :content, presence: true

  def replies
    Comment.where(original_comment_id: id)
  end

  def liked?(user_id)
    opinions.where(user_id: user_id).any?{ |opinion| opinion.value == true }
  end

  def disliked?(user_id)
    opinions.where(user_id: user_id).any?{ |opinion| opinion.value == false }
  end

  def likes
    opinions.where(value: true).count
  end

  def dislikes
    opinions.where(value: false).count
  end
end
