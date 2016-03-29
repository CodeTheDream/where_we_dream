class Story < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :description, :body, :user

  has_many :opinions, as: :opinionable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  include Opinionable

  def self.search(search)
    if search
      search_length = search.split.length
      if Rails.env.development?
        array = ((search.split*2).sort).map{ |term| term[/anonymous/i] ? true : "%#{term}%"}
        where([(['title LIKE ? OR cast(anonymous as text) LIKE ?'] * search_length).join(' AND ')] + (array))
      else
        array = ((search.split*2).sort).map{ |term| term[/anonymous/i] ? "%true%" : "%#{term}%"}
        where([(['title ILIKE ? OR CAST(anonymous AS text) ILIKE ?'] * search_length).join(' AND ')] + (array))
      end
    else
      all
    end
  end

  def author
    if anonymous
      "anonymous"
    else
      user.name
    end
  end
end
