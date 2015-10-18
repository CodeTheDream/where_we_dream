class School < ActiveRecord::Base
  validates :name, presence: true, allow_blank: true
  validates :students, numericality: true, allow_blank: true
  validates :undocumented_students, numericality: true, allow_blank: true
  validates :zip, format: { with: /\A\d{5}(\z|-\d{4}\z)/, message: "Zip code should be 12345 or 12345-1234" }, allow_blank: true

  has_many :rules, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :opinions, as: :opinionable, dependent: :destroy

  accepts_nested_attributes_for :rules

  attr_accessor :info

  def self.search(search)
    if search
      Rails.env.development?
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

  def self.states
    %w[
      AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO
      MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY
    ]
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
    (((rules.all.select(&:answer).count).to_f/(rules.count).to_f)*100).round(2) rescue 0
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
