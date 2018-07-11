dataHrefClick = ->
  $('*[data-href]').on 'click', (e) ->
    href = $(@).data 'href'
    cmd = e.metaKey # for mac support
    ctrl = e.ctrlKey # for windows support

    if cmd || ctrl
      open href
    else
      window.location = href

$ dataHrefClick
