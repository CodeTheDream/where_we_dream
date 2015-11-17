class School < ActiveRecord::Base
  validates :name, presence: true, allow_blank: true
  validates :students, numericality: true, allow_blank: true
  validates :undocumented_students, numericality: true, allow_blank: true
  validates :zip, format: { with: /\A\d{5}(\z|-\d{4}\z)/, message: "Zip code should be 12345 or 12345-1234" }, allow_blank: true
  validates :link, url: true, allow_blank: true

  has_many :rules, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :opinions, as: :opinionable, dependent: :destroy

  accepts_nested_attributes_for :rules

  attr_accessor :info

  include Opinionable

  def self.search(search)
    if search
      search_length = search.split.length
      if Rails.env.development?
        array = ((search.split*3).sort).map{ |term| term[/public|private/i] ? term[/public/i] ? true : false : "%#{term}%"}
        where([(['name LIKE ? OR city LIKE ? OR cast(public as text) LIKE ?'] * search_length).join(' AND ')] + (array))
      else
        array = ((search.split*3).sort).map{ |term| term[/public|private/i] ? term[/public/i] ? "%true%" : "%false%" : "%#{term}%"}
        where([(['name ILIKE ? OR city ILIKE ? OR CAST(public AS text) ILIKE ?'] * search_length).join(' AND ')] + (array))
      end
    else
      all
    end
  end

  def address
    if street.blank?
      if (city.blank?) || (state.blank? || zip.blank?)
        nil
      else
        "#{city}, #{state} #{zip}"
      end
    else
      if (city.blank?) || (state.blank? || zip.blank?)
        nil
      else
        "#{street}, #{city}, #{state} #{zip}"
      end
    end
  end

  def rating!
    {1 => "A", 2 => "B", 3 => "C", 4 => "D", 5 => "F", 6 => "INC"}[rating.to_i] || "?"
  end

  def public?
    public ? 'Public' : 'Private'
  end

  def complete?
    # if any of the school attributes == nil or any of it's rules don't have answers
    !(attributes.values.include?(nil) || rules.select(&:no_answer?).any?)
  end

  def info
    incomplete?
  end
end
