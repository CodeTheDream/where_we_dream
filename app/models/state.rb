class State < ActiveRecord::Base
  validates_presence_of :name, :abbreviation

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :opinions, as: :opinionable, dependent: :destroy

  def schools
    School.where(state: abbreviation).order(name: :asc)
  end

  def in_state?
    if in_state
      "#{abbreviation} grants undocumented students in-state status."
    else
      "#{abbreviation} does not grant undocumented students in-state status."
    end
  end

  def self.names
    %w[Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada New\ Hampshire New\ Jersey New\ Mexico New\ York North\ Carolina North\ Dakota Ohio Oklahoma Oregon Pennsylvania Rhode\ Island South\ Carolina South\ Dakota Tennessee Texas Utah Vermont Virginia Washington West\ Virginia Wisconsin Wyoming]
  end

  def self.names_left
    names - names_taken
  end

  def self.names_taken
    State.all.map &:name
  end

  def self.abbreviate(string)
    Hash[names.zip(abbreviations)][string]
  end

  def self.abbreviations
    %w[AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY]
  end
end
