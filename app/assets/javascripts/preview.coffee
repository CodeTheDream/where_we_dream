preview = ->
  $('.preview').click ->
    form = $ 'form'
    url = form.attr('action').replace /[^\D]/g, ''

    # Sends data
    $.ajax
      url: "#{url}/preview"
      type: 'PATCH'
      data: form.serialize()

    # Stops form from submitting
    false

$ preview
