class Identity < ActiveRecord::Base
  belongs_to :user

  def self.find_or_create(auth)
    Identity.where(
      uid: auth.uid,
      provider: auth.provider
    ).first_or_create do |identity|
      identity.provider = auth.provider
      identity.uid      = auth.uid
    end
  end
end
