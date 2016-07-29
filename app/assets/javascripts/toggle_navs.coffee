toggleNavs = ->
  $('#js-navigation-menu li').click ->
    nav = $("#nav-#{@id}")
    hidden = nav.is ':hidden'
    $('.nav').hide()
    if hidden
      nav.css 'display', 'flex'

$ toggleNavs
