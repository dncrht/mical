$('.day').tooltip();

$('.day').click(function(e){
    if ($(this).data('activity')) {
        $('#delete').show();
    } else {
        $('#delete').hide();
    }

    if (!$('#replace').is(':visible')) {
        var month = $(this).closest('table').find('.caption th').html();
        var day = $(this).data('day').split('-')[2];
        $('#today').html(day + '<p>' + month + '</p>');
    } else {
        return;
    }
    $('#replace').slideToggle();

    if ($('#years').is(':visible')) $('#years').slideToggle();

    $('#activity_id option[value=' + $(this).data('activity') + ']').attr('selected', true);
    $('#description').html($(this).data('original-title'));
    $('#day').val($(this).data('day'));
});

$('#cancel').click(function(){
    $('#replace').slideToggle();
    $('#today').html($('#today').data('day') + '<p>' + $('#today').data('month') + '</p>');
});

$('#year').click(function(){
    if ($('#replace').is(':visible')) $('#replace').slideToggle();
    $('#years').slideToggle();
});

$('#delete').click(function(){
    if (!confirm('Are you sure?')) {
        return;
    }
    $('input[name=_method]').val('delete');
    $('#replace form').submit();
});

$('.alert').append('<button type="button" class="close">×</button>');

$('.close').live('click', function(){
    $(this).parent().fadeOut();
});

$('.help-inline.error').closest('.control-group').addClass('error');

$('#activity_color').after('<div id="colorpicker"></div>');
$('#colorpicker').farbtastic('#activity_color');
