class Scholarship < ActiveRecord::Base
  validates_presence_of :name, :requirements, :deadline
  validate :amount_or_full_ride

  has_many :opinions, as: :opinionable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  include Opinionable

  def open?
    deadline >= Time.now
  end

  def self.search(search)
    if search
      search_length = search.split.length
      if Rails.env.development?
        array = ((search.split*2).sort).map{ |term| term[/full ride /i] ? "%true%" : "%#{term}%" }
        where([(['name LIKE ? OR cast(full_ride as text) LIKE ?'] * search_length).join(' AND ')] + (array))
      else
        array = ((search.split*2).sort).map{ |term| term[/full ride /i] ? "%true%" : "%#{term}%" }
        where([(['name ILIKE ? OR CAST(full_ride AS text) ILIKE ?'] * search_length).join(' AND ')] + (array))
      end
    else
      all
    end
  end

  private

  def amount_or_full_ride
    if amount.blank? && full_ride.blank?
      errors.add(:_, "You need to either specify that this is a full ride scholarship or the amount of money that is rewarded")
    end
  end
end
