module OpinionablesHelper
  def dislikes(resource)
    if resource.disliked_by?(user_id)
      hide = ""
      dislikes = resource.dislikes
    else
      hide = " hide"
      dislikes = resource.dislikes + 1
    end
    dislikes = dislikes.to_s
    ("<span class='dislikes"+hide+"'>"+dislikes+"</span>").html_safe
  end

  def likes(resource)
    if resource.liked_by?(user_id)
      hide = ""
      likes = resource.likes
    else
      hide = " hide"
      likes = resource.likes + 1
    end
    likes = likes.to_s
    ("<span class='likes"+hide+"'>"+likes+"</span>").html_safe
  end

  def likes_bar(opinionable, flex: false, sides: false, bottom: false, mobile: false)
    bm = bottom ? mobile ? "bottom-margin-2" : "bottom-margin" : ""
    bm += " short-bar" if sides
    bm += " flex" if flex
    if opinionable.likes! == "no opinions"
      "<div class='no-opinions-bar #{bm}'></div>".html_safe
    else
      "<div class='dislikes-bar #{bm}'>
        <div class='likes-bar' width='#{opinionable.likes!}%'></div>
      </div>".html_safe
    end
  end

  def thumbs_down(resource)
    resource.disliked_by?(user_id) ? disliked = " disliked": disliked = ""
    ("<i class='fa fa-thumbs-down opinion" + disliked + "'></i>").html_safe
  end

  def thumbs_up(resource)
    resource.liked_by?(user_id) ? liked = " liked": liked = ""
    ("<i class='fa fa-thumbs-up opinion" + liked + "'></i>").html_safe
  end
end
