smoothScroll = ->
  $('a[href*=\\#]:not([href=\\#])').click ->
    path = $(@).attr 'href'
    link = $ "a[name=#{path.slice(1)}]"
    start = $(window).scrollTop()
    stop = target = setDestination link
    distance = Math.abs start - stop
    time = putTime distance
    link.closest('h3').addClass 'highlight'
    $('html,body').animate {scrollTop: target}, time, removeHighlight
    false

setDestination = (link) ->
  value = link.offset().top
  if $(window).width() > 768
    value -= 85
  value

putTime = (distance) ->
  if distance < 1000
    distance*3/5
  else if distance < 2000
    distance/2
  else if distance < 4000
    distance/4
  else
    distance/5

removeHighlight = ->
  $('.highlight').removeClass 'highlight'

$ smoothScroll
