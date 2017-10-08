mical = (->
  collapseIfVisible = (selector) ->
    if $(selector).is(':visible')
      $(selector).slideUp()

  renderDay = (month, day) ->
    $('.header-day').html(day + '<p class="header-month">' + month + '</p>')

  initialize: ->
    $('.js-day-click').tooltip()
    $('.alert').prepend('<button type="button" class="close js-close">×</button>')

    $('.help-inline.error').closest('.control-group').addClass('error')

    activityColor = $('#activity_color')
    if activityColor.length != 0
      activityColor.after('<div id="colorpicker"></div>')
      $('#colorpicker').farbtastic('#activity_color')

  dayClicked: (event) ->
    if $('.js-form').is(':visible')
      return

    $('.js-form').slideDown()

    collapseIfVisible('.header-years-dropdown')

    $clickedDay = $(event.currentTarget)
    month = $clickedDay.closest('table').find('.month-header').html()
    day = $clickedDay.data('day').split('-')[2]
    renderDay(month, day)

  cancelForm: ->
    $('.js-form').slideUp()
    dayIndicator = $('.header-day')
    renderDay(dayIndicator.data('month'), dayIndicator.data('day'))

  closeX: (event) ->
    $(event.currentTarget).parent().fadeOut()

  yearDropdown: ->
    collapseIfVisible('.js-form')
    $('.header-years-dropdown').slideToggle()
)()

mical.initialize()

$('body').on 'click', '.js-day-click', mical.dayClicked.bind(mical)
$('body').on 'click', '.js-cancel', mical.cancelForm.bind(mical)
$('body').on 'click', '.js-year-selection', mical.yearDropdown.bind(mical)
$('body').on 'click', '.js-close', mical.closeX.bind(mical)
