class School < ActiveRecord::Base
  validates :name, presence: true, allow_blank: true
  validates :students, numericality: true, allow_blank: true
  validates :undocumented_students, numericality: true, allow_blank: true
  validates :zip, format: { with: /\A\d{5}(\z|-\d{4}\z)/, message: "Zip code should be 12345 or 12345-1234" }, allow_blank: true

  has_many :rules, dependent: :destroy

  accepts_nested_attributes_for :rules

  def self.search(search)
    if search
      # hits = []
      # terms = search.split
      # terms.each do |term|
      #   School.where("name LIKE :q OR city LIKE :q",q: "%#{term}%")
      # end
      # where("name LIKE ? OR city LIKE ?","%#{search}%","%#{search}%")
      if search[/public|private/i]
        search.gsub(/public/i, "true")
      end
      search_length = search.split.length
      array = ((search.split*3).sort).map{ |term| term[/public|private/i] ? term[/public/i] ? true : false : "%#{term}%"}
      p array
      where([(['name LIKE ? OR city LIKE ? OR public LIKE ?'] * search_length).join(' AND ')] + (array))
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
end
