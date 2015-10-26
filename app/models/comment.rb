class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :opinions, as: :opinionable, dependent: :destroy

  validates_presence_of :content, :user, :commentable

  include Opinionable

  def replies
    Comment.where(original_comment_id: id)
  end

  def owner? person
    return false if %w[User Fixnum].include? person.class
    if person.class == User
      user.id == person.id
    else
      user.id == person
    end
  end
end
