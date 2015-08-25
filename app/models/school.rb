class School < ActiveRecord::Base
  validates :name, presence: true, allow_blank: true
  validates :students, numericality: true, allow_blank: true
  validates :undocumented_students, numericality: true, allow_blank: true
  validates :zip, length: {is: 5}, allow_blank: true

  has_many :rules, dependent: :destroy

  accepts_nested_attributes_for :rules

  # def initialize(*strings)
  #   p strings
  #   capitalize(strings)
  #   save
  # end

  def self.search(search)
    if search
      where(["name LIKE ?","%#{search}%"])
    else
      all
    end
  end

  def address
    if (street.blank? || city.blank?) || (state.blank? || zip.blank?)
      nil
    else
      "#{street}, #{city}, #{state} #{zip}"
    end
  end

  def self.capitalize(string)
    (string.split.map &:capitalize).join(' ')
  end
end
