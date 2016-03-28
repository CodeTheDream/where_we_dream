class User < ActiveRecord::Base
  has_many :stories
  has_attached_file :image, styles: { large: "230x230#", medium: "160x160#", small: "100x100#", thumb: "50x50#", xs: "28x28#" }, default_url: "/default_1.jpg"

  has_many :identities, dependent: :destroy

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validate :first_name_presence
  validate :email_presence
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i } # with format

  # Checks password presence.
  # Skip because length validation is another form of presence validation
  # If you skip the validation, why not just delete this line?
  # Without this line, the passwords won't be encrypted onto the db. They won't even be saved.
  has_secure_password validations: false

  # Password length validator.
  # Validate on create because :password is not an actual attribute. When updating, you will not be sending any :password, but the validation will run anyway, and cause any update to fail
  # unless: outh because if the user was created from oauth, password is not required.
  validates :password, length: { minimum: 6, maximum: 20 }, on: :create, unless: :from_oauth

  # Without this line, oauth cannot be passed as an attribute during creation.
  attr_accessor :from_oauth

  validate :user_type_presence, unless: :from_oauth

  validates :twitter_name, uniqueness: true, allow_blank: true

  def self.search(search)
    if search
      search_length = search.split.length
      array = ((search.split*3).sort).map{ |term| "%#{term}%"}
      where([(['first_name LIKE ? OR last_name LIKE ? OR user_type LIKE ?'] * search_length).join(' AND ')] + (array))
    else
      all
    end
  end

  def self.from_omniauth(auth)
    identity = Identity.find_or_create(auth)
    user = User.find_with_omniauth(auth)
    if identity.user
      user = identity.user
      if user.twitter_name != auth.nickname
        user.update(twitter_name: auth.nickname)
      end
    elsif !user
      user = User.create_from_omniauth(auth)
    end
    user.identities << identity
    user
  end

  def self.find_with_omniauth(auth)
    if auth.twitter?
      User.find_by_twitter_name(auth.nickname)
    else
      User.find_by_email(auth.email)
    end
  end

  # For when a user is logging in with oauth for the first time.
  # Devise requires email and password.
  # OAuth doesn't send passwords, Twitter doesn't send email everytime.
  # So we also add nickname.
  def self.create_from_omniauth(auth)
    create(
      email: auth.email,
      twitter_name: auth.nickname,
      first_name: auth.first_name,
      last_name: auth.last_name,
      city: auth.city,
      state: auth.state,
      activated: true,
      from_oauth: true
      # image: auth.image
    )
  end

  def self.students
    where(user_type: "Student")
  end

  def type
    user_type
  end

  def viewer?
    %w[Student Teacher Parent Supporter].include?(type)
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

  def below_admin?
    !%w[God Admin].include?(user_type)
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

  def does_not_have_enough_profile_info?
    image.blank?
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
      errors.add(:___, 'You need to choose a category from the dropdown that fits you')
    end
  end

end
