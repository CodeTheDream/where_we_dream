class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :opinions, as: :opinionable, dependent: :destroy

  validates_presence_of :content, :user, :commentable

  include Opinionable

  def replies
    Comment.where(original_comment_id: id)
  end
end
