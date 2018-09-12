toggleNavs = ->
  $('#js-navigation-menu li').click ->
    header = $('header')
    # fetch the corresponding navigation panel
    nav = $("#nav-#{@id}")
    # determine if nav is hidden
    hidden = nav.is ':hidden'
    landing = header.is '.landing'
    # hide all .navs
    $('.nav').hide()
    # show selected nav if it is hidden
    nav.css 'display', 'flex' if hidden
    if landing
      if hidden
        header.removeClass('top')
      else
        header.addClass('top')

scrollNav = ->
  $(window).scroll ->
    header = $('header')
    landing = header.is '.landing'
    top = $(window).scrollTop()
    if landing && top == 0
      header.addClass 'top'
    else
      header.removeClass 'top'

$ toggleNavs
$ scrollNav
