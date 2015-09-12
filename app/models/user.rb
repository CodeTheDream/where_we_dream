class User < ActiveRecord::Base
  has_secure_password

  def self.search(search)
    if search
      search_length = search.split.length
      array = ((search.split*3).sort).map{ |term| term[/public|private/i] ? term[/public/i] ? true : false : "%#{term}%"}
      where([(['first_name LIKE ? OR last_name LIKE ? OR user_type LIKE ?'] * search_length).join(' AND ')] + (array))
    else
      all
    end
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
end
