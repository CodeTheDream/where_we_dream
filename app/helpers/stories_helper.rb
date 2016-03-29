module StoriesHelper
  def author
    unless @story.anonymous
      link_to @story.author, @story.user
    else
      "anonymous"
    end
  end
end
