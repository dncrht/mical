mical = (->
  initialize: ->
    $('.month-day').tooltip()
    $('.alert').prepend('<button type="button" class="close js-close">×</button>')

  closeX: (event) ->
    $(event.currentTarget).parent().fadeOut()

  yearDropdown: ->
    $('.header-years-dropdown').slideToggle()
)()

mical.initialize()

$('body').on 'click', '.js-year-selection', mical.yearDropdown.bind(mical)
$('body').on 'click', '.js-close', mical.closeX.bind(mical)
