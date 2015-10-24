class User < ActiveRecord::Base
  has_attached_file :image, styles: { large: "230x230>", medium: "160x160>", small: "100x100>", thumb: "50x50>", xs: "28x28>" }, default_url: "/default_1.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validate :first_name_presence
  validate :email_presence
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i } # with format
  has_secure_password
  validates :password, length: { minimum: 6, maximum: 20 }, on: :create # on: :create because :password is not an actual attribute. When updating, you will not be sending any :password, but the validation will run anyway, and cause any update to fail
  validate :user_type_presence

  def self.search(search)
    if search
      search_length = search.split.length
      array = ((search.split*3).sort).map{ |term| term[/public|private/i] ? term[/public/i] ? true : false : "%#{term}%"}
      where([(['first_name LIKE ? OR last_name LIKE ? OR user_type LIKE ?'] * search_length).join(' AND ')] + (array))
    else
      all
    end
  end

  def self.students
    where(user_type: "Student")
  end

  def type
    user_type
  end

  def viewer?
    %w[Student Teacher Parent].include?(type)
  end

  def is_in_session?(user_id)
    id == user_id
  end

  def user_type!
    user_type == "God" ? "Creator" : user_type
  end

  def name
    first_name + " " + last_name
  end

  def location
    city.blank? || state.blank? ? nil : city + ", " + state
  end

  def team_member?
    %w[God Admin Recruiter Moderator].include?(user_type)
  end

  def opinions
    Opinion.where(user_id: id)
  end

  def likes?(resource)
    resource.liked_by?(self)
  end

  def dislikes?(resource)
    resource.disliked_by?(self)
  end

  private

  def email_presence
    if email.blank?
      errors.add(:_, "We need your email. That's how you will log in")
    end
  end

  def first_name_presence
    if first_name.blank?
      errors.add(:__, "At least give us your first name")
    end
  end

  def user_type_presence
    if user_type.blank?
      errors.add(:___, "You need to choose a category from the dropdown that fits you")
    end
  end

end
