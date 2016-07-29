toggleNavs = ->
  console.log('running')
  $('#js-navigation-menu li').click ->
    console.log('click')
    nav = $("#nav-#{@id}")
    console.log('id: ' +@id)
    hidden = nav.is ':hidden'
    console.log('hidden: ' + hidden)
    $('.nav').hide()
    if hidden
      nav.css 'display', 'flex'

$ toggleNavs
