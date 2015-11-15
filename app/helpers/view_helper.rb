module ViewHelper
  def anchor_link(phrase, link = nil)
    "<li><a href='##{link || phrase}' class='anchor-link'>#{phrase}</a></li>".html_safe
  end

  def anchor_tag(phrase, link = nil, tag: nil, top: true)
    top = top ? "<a href='#top' class='small'>Back to top</a>" : ""
    link = link || phrase
    if tag == false
      "<a name='#{link}'></a>".html_safe
    else
      "<a name='#{link}'></a><#{tag || "h3"}>#{phrase} #{top}</#{tag || "h3"}>".html_safe
    end
  end

  def back
    link_to '<span class="button dark-blue-background submit"><i class="fa fa-arrow-left"></i> Back<span>'.html_safe, :back
  end

  def desktop_mobile(hash)
    hash = hash.map{ |key, value| desktop_only(key) + mobile_only(value) }
    hash.size == 1 ? hash[0] : hash
  end

  def desktop_only(string = "")
    "<span class='desktop-only'>#{string}</span>".html_safe
  end

  def mobile_only(string = "")
    "<span class='mobile-only'>#{string}</span>".html_safe
  end

  def notice_helper
    style = @page == 'home' ?  ' style="position:relative"' : nil
    "<p id='notice'#{style}>#{notice}</p>".html_safe
  end
end