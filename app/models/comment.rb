class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  def created_at!
    created_at.to_datetime
  end
end
