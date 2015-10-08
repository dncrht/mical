class @View extends AbstractView
  events:
    'click .js-day-click': 'dayClicked',
    'click .js-cancel': 'cancelForm',
    'click .js-delete': 'deleteForm',
    'click .js-year-selection': 'yearDropdown',
    'click .js-upload-dropzone button': 'openFile',
    'click .js-close': 'closeX'

  constructor: ->
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

    @_collapseIfVisible('.header-years-dropdown')

    $clickedDay = $(event.currentTarget)
    month = $clickedDay.closest('table').find('.month-header').html()
    day = $clickedDay.data('day').split('-')[2]
    @_renderDay(month, day)

  cancelForm: ->
    $('.js-form').slideUp()
    dayIndicator = $('.header-day')
    @_renderDay(dayIndicator.data('month'), dayIndicator.data('day'))

  deleteForm: ->
    if not confirm('Are you sure?')
      return

    $('input[name=_method]').val('delete')
    $('.js-form form').submit()

  closeX: (event) ->
    $(event.currentTarget).parent().fadeOut()

  yearDropdown: ->
    @_collapseIfVisible('.js-form')
    $('.header-years-dropdown').slideToggle()

  openFile: ->
    $('.js-upload-asset').click()

  _collapseIfVisible: (selector) ->
    if $(selector).is(':visible')
      $(selector).slideUp()

  _renderDay: (month, day) ->
    $('.header-day').html(day + '<p class="header-month">' + month + '</p>')

# Adapted from https://github.com/blueimp/jQuery-File-Upload/wiki/Drop-zone-effects
$(document).bind 'dragover', (e) =>
  timeout = window.dropZoneTimeout
  if timeout
    clearTimeout timeout
  node = e.target
  found = $('.js-upload-dropzone')[0] == node
  $('.js-upload-dropzone').toggleClass 'hover', found
  window.dropZoneTimeout = setTimeout(=>
    window.dropZoneTimeout = null
    $('.js-upload-dropzone').removeClass 'hover'
  , 100)
