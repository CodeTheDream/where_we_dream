previous = 0

hideHeader = ->
  $(window).scroll ->
    scroll_down = $(window).scrollTop() > previous
    nav_is_closed = !( $('.nav').is(':visible') )
    window_is_phone_width = $(window).width() <= 768
    if scroll_down
      removeNotice()
      if nav_is_closed && window_is_phone_width
        if !($('header').is('.header--hidden'))
          $('header').addClass('header--hidden')
    else if $('header').is('.header--hidden')
      $('header').removeClass('header--hidden')
    previous = $(window).scrollTop()

removeNotice = ->
  $('#notice').fadeOut 500, -> $(@).remove()

$ hideHeader
