module OpinionablesHelper
  def dislikes(resource)
    dislikes = resource.dislikes
    if resource.disliked_by?(user_id)
      hide = ''
    else
      hide = 'hide'
      dislikes += 1
    end
    %(<span class="dislikes #{hide}">#{dislikes}</span>).html_safe
  end

  def likes(resource)
    likes = resource.likes
    if resource.liked_by?(user_id)
      hide = ''
    else
      hide = 'hide'
      likes += 1
    end
    %(<span class="likes #{hide}">#{likes}</span>).html_safe
  end

  def likes_bar(opinionable, flex: false, sides: false, bottom: false, mobile: false)
    bm = bottom ? mobile ? "bottom-margin-2" : "bottom-margin" : ""
    bm += " short-bar" if sides
    bm += " flex" if flex
    percentage = opinionable.likes!
    if percentage == "no opinions"
      "<div class='no-opinions-bar #{bm}'></div>".html_safe
    else
      "<div class='dislikes-bar #{bm}'>
        <div class='likes-bar' width='#{percentage}%'></div>
      </div>".html_safe
    end
  end

  def thumbs_down(resource)
    disliked = resource.disliked_by?(user_id) ? 'disliked' :  ''
    %(<i class="fa fa-thumbs-down opinion #{disliked}"></i>).html_safe
  end

  def thumbs_up(resource)
    liked = resource.liked_by?(user_id) ? 'liked' : ''
    %(<i class="fa fa-thumbs-up opinion #{liked}"></i>).html_safe
  end
end
