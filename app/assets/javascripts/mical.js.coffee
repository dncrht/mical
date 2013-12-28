class @View extends AbstractView
  events:
    'click .day': 'dayClicked',
    'click #cancel': 'cancelForm',
    'click #delete': 'deleteForm',
    'click #year':   'yearDropdown',
    'click .close':  'closeX'

  constructor: ->
    $('.day').tooltip()
    $('.alert').append('<button type="button" class="close">×</button>')

    $('.help-inline.error').closest('.control-group').addClass('error')

    activityColor = $('#activity_color')
    if activityColor.length != 0
      activityColor.after('<div id="colorpicker"></div>')
      $('#colorpicker').farbtastic('#activity_color')

  dayClicked: (event) ->
    if $('#replace').is(':visible')
      return

    $clickedDay = $(event.currentTarget)

    if $clickedDay.data('activity')
      $('#delete').show()
    else
      $('#delete').hide()

    $('#replace').slideDown()

    @collapseIfVisible('#years')

    @displayDay($clickedDay)

    @fillForm($clickedDay)

  displayDay: ($day) ->
    month = $day.closest('table').find('.caption th').html()
    day = $day.data('day').split('-')[2]
    $('#today').html(day + '<p>' + month + '</p>')

  fillForm: ($day) ->
    $('#activity_id option[value=' + $day.data('activity') + ']').attr('selected', true)
    $('#description').html($day.data('original-title'))
    $('#day').val($day.data('day'))

  cancelForm: ->
    $('#replace').slideUp()
    $('#today').html($('#today').data('day') + '<p>' + $('#today').data('month') + '</p>')

  deleteForm: ->
    if not confirm('Are you sure?')
      return

    $('input[name=_method]').val('delete')
    $('#replace form').submit()

  closeX: (event) ->
    $(event.currentTarget).parent().fadeOut()

  yearDropdown: ->
    @collapseIfVisible('#replace')
    $('#years').slideDown()

  collapseIfVisible: (selector) ->
    if $(selector).is(':visible')
      $(selector).slideUp()
