$(document).ready(function(){
    $('.day').click(function(e){
        $('#replace').css('top', e.pageY);
        $('#replace').css('left', e.pageX);

        if ($(this).attr('data-activity')) {
            $('.delete').show();
        } else {
            $('.delete').hide();
        }
        
        $('#replace').toggle();
        if (!$('#replace').is(':visible')) return;

        $('#activity_id option[value=' + $(this).attr('data-activity') + ']').attr('selected', true);
        $('#resumen').html($(this).attr('title'));
        $('#day').val($(this).attr('data-day'));
    });

    $('#cancel').click(function(){
        $('#replace').hide();
    });

    $('input.delete').click(function(){
        $('button.delete').attr('disabled', null);
    });

    $('button.delete').click(function(){
        if (!confirm('Are you sure?')) {
            return;
        }
        $('input[name=_method]').val('delete');
        $('#replace form').submit();
    });
});