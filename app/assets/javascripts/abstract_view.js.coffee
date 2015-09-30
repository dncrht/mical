# Reference: https://gist.github.com/dncrht/8158573

class @AbstractView
  constructor: ->
    console.log "I'm not meant to be instantitated"

  render: ->
    for event_selector of @events
      event_selector_array = event_selector.split(' ')
      event = event_selector_array.reverse().pop()
      selector = event_selector_array.reverse().join(' ')

      callback = eval('this.' + @events[event_selector]).bind(@)
      $('body').on(event, selector, callback)


$(document).ready ->
  view = new View
  view.render()
