$('.day').tooltip()

$('.day').click (event) ->
  if $(event.currentTarget).data('activity')
    $('#delete').show()
  else
    $('#delete').hide()

  if $('#replace').is(':visible')
    return

  month = $(event.currentTarget).closest('table').find('.caption th').html()
  day = $(event.currentTarget).data('day').split('-')[2]
  $('#today').html(day + '<p>' + month + '</p>')

  $('#replace').slideToggle()

  if $('#years').is(':visible')
    $('#years').slideToggle()

  $('#activity_id option[value=' + $(event.currentTarget).data('activity') + ']').attr('selected', true)
  $('#description').html($(event.currentTarget).data('original-title'))
  $('#day').val($(event.currentTarget).data('day'))

$('#cancel').click ->
  $('#replace').slideToggle()
  $('#today').html($('#today').data('day') + '<p>' + $('#today').data('month') + '</p>')

$('#year').click ->
  if $('#replace').is(':visible')
    $('#replace').slideToggle()
  $('#years').slideToggle()

$('#delete').click ->
  if not confirm('Are you sure?')
    return

  $('input[name=_method]').val('delete')
  $('#replace form').submit()

$('.alert').append('<button type="button" class="close">×</button>')

$('.close').on click: (event) ->
  $(event.currentTarget).parent().fadeOut()

$('.help-inline.error').closest('.control-group').addClass('error')

activityColor = $('#activity_color')
if activityColor.length != 0
  activityColor.after('<div id="colorpicker"></div>')
  $('#colorpicker').farbtastic('#activity_color')
