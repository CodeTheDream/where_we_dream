setCoverHeight = ->
  height = $(window).height()
  $('.cover').height height

responsiveCoverHeight = ->
  $(window).resize setCoverHeight

$ setCoverHeight
$ responsiveCoverHeight
