class User < ActiveRecord::Base
  has_secure_password

  def type
    user_type
  end
end
