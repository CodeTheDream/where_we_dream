class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likable, dependent: :destroy

  validates :content, presence: true

  def created_at!
    created_at.to_datetime
  end

  def replies
    Comment.where(original_comment_id: id)
  end
end
