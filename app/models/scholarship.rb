class Scholarship < ActiveRecord::Base
  validates_presence_of :name, :requirements, :deadline
  validate :amount_or_full_ride

  has_many :opinions, as: :opinionable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  include Opinionable

  def open?
    deadline >= Time.now
  end

  def self.search(query)
    # if User.search is called without params, simply return User.all
    # return all unless query
    return all unless query

    # array of columns you want to search for
    attrs = %w(name description)

    # get the number of words in a query. the query "john doe smith" has 3 words
    words = query.split

    # split "john doe smith" into ["john", "doe", "smith"]
    # multiply by the number of columns you are searching for
    # if columns = [first_name and last_name], then multiply by 2
    # ["john", "doe", "smith", "john", "doe", "smith"]
    # sort it: ["doe", "doe", "john", "john", "smith", "smith"]
    # wrap with %'s to allow wildcard searches
    # ["%doe%", "%doe%", "%john%", "%john%", "%smith%", "%smith%"]
    terms = (words * attrs.size).sort.map { |term| "%#{term}%" }

    # use case insensitive operator
    # allows to find 'John' with 'john', 'JOHN', 'jOhN', etc
    # sqlite3's operator for case insensitivity is LIKE
    # postgres's operator for case insensitivity is ILIKE

    operator = Rails.env.production? ? 'ILIKE' : 'LIKE'


    # turn columsn into SQL phrase
    # ['first_name', 'last_name'] => "(first_name like ? OR last_name like ?)"
    phrase = %`(#{attrs.map { |c| "#{c} #{operator} ?" }.join(' OR ')})`

    # multiply by 3 if words.size = 3. join with ' AND '
    # (first_name LIKE ? OR last_name LIKE ?) AND
    # (first_name LIKE ? OR last_name LIKE ?) AND
    # (first_name LIKE ? OR last_name LIKE ?)
    # pass that string in and the array of terms to get sql like:
    # (first_name LIKE "%doe%" OR last_name LIKE "%doe%") AND
    # (first_name LIKE "%john%" OR last_name LIKE "%john%") AND
    # (first_name LIKE "%smith%" OR last_name LIKE "%smith%")
    # joins() searches customers that have 1+ billing_address & locations
    # left_joins() searches customers that have 0+ billing or locations
    # left_joins() can cause duplicate rows because of has_many :locations
    where ([phrase] * words.size).join(' AND '), *terms
  end

  private

  def amount_or_full_ride
    if amount.blank? && full_ride.blank?
      errors.add(:_, "You need to either specify that this is a full ride scholarship or the amount of money that is rewarded")
    end
  end
end
