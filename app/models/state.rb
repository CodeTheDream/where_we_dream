class State < ActiveRecord::Base
  validates_presence_of :name, :abbreviation

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :opinions, as: :opinionable, dependent: :destroy

  def in_state_css
    options[:css_class]
  end

  def in_state_message
    abbreviation + options[:message]
  end

  def options
    State.options[in_state]
  end

  def schools
    School.where(state: abbreviation).order(name: :asc)
  end

  def self.names_left
    names_taken = State.all.map &:name
    names - names_taken
  end

  def self.abbreviate(string)
    Hash[names.zip(abbreviations)][string]
  end

  def self.abbreviations
    %w[AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY]
  end

  def self.names
    %w[Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada New\ Hampshire New\ Jersey New\ Mexico New\ York North\ Carolina North\ Dakota Ohio Oklahoma Oregon Pennsylvania Rhode\ Island South\ Carolina South\ Dakota Tennessee Texas Utah Vermont Virginia Washington West\ Virginia Wisconsin Wyoming]
  end

  def self.options
    {
      0 => {
        css_class: "out-of-state",
        message: " does not grant undocumented students in-state status.",
        option: "Anti-immigrant"
      },
      1 => {
        css_class: "neutral",
        message: " is neatral towards undocumented students or there is not enough information.",
        option: "Neutral"
      },
      2 => {
        css_class: "in-state",
        message: " grants undocumented students in-state status.",
        option: "In-state"
      },
      3 => {
        css_class: "in-state-aid",
        message: " grants undocumented students in-state status & offers state financial aid.",
        option: "In-state & state aid"
      },
      4 => {
        css_class: "university-aid",
        message: "'s university systems offer in-state tuition.",
        option: "Universities provide in-state"
      }
    }
  end
end
