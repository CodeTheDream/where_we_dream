toggleNavs = ->
  $('#js-navigation-menu li').click ->
    nav = $("#nav-#{@id}")
    hidden = nav.is ':hidden'
    $('.nav').hide()
    nav.css 'display', 'flex' if hidden

$ toggleNavs
