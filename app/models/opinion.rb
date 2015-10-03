class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :opinionable, polymorphic: true
  validates :user_id, uniqueness: { scope: [:opinionable_id, :opinionable_type]  }
end
