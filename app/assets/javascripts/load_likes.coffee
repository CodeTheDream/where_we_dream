loadLikes = ->
  $.each $('.likes-bar'), ->
    @.style.width = $(@).attr 'width'
  $.each $('.no-opinions-bar'), ->
    @.style.background = 'lightgray'

$ loadLikes
