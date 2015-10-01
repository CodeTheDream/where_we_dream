class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likable, polymorphic: true
  # validates :user_id, uniqueness: { scope: :post_id }
end
