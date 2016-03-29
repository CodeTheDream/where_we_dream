module OmniAuth
  # Monkeypatched for easier retrieval of data
  class AuthHash
    # Works with Facebook, Twitter
    def first_name
      info.name.split.first
    end

    # Works with Facebook, Twitter
    def last_name
      ary = info.name.split
      ary.last unless ary.size == 1
    end

    # Works with Facebook
    def email
      info.email.to_s
    end

    # Works with Twitter
    def city
      info.location.split(',').first
    rescue NoMethodError
      nil
    end

    # Works with Twitter
    def state
      info.location.split(',').last.strip
    rescue NoMethodError
      nil
    end

    delegate :image, :nickname, to: :info, allow_nil: true

    def twitter?
      provider == 'twitter'
    end
  end
end
