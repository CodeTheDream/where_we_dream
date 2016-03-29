module CommentsHelper
  def delatable?(comment)
    user = comment.user.type
    # This comment is delatable if you are the owner, a modder and the owner is a viewer, or you are Cruz
    comment.owner?(user_id) || ( modder_or_above? && modder_or_below_of?(comment.user) ) || god?
  end

  def owner?(comment)
    comment.user.id == session[:user_id]
  end
end
