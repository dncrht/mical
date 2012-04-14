$(document).ready(function(){
    $('.day').click(function(e){
        if ($(this).data('activity')) {
            $('#delete').show();
        } else {
            $('#delete').hide();
        }
        
        $('#replace').slideToggle();
        if (!$('#replace').is(':visible')) return;

        $('#activity_id option[value=' + $(this).data('activity') + ']').attr('selected', true);
        $('#resumen').html($(this).attr('title'));
        $('#day').val($(this).data('day'));
    });

    $('#cancel').click(function(){
        $('#replace').slideToggle();
    });

    $('#delete').click(function(){
        if (!confirm('Are you sure?')) {
            return;
        }
        $('input[name=_method]').val('delete');
        $('#replace form').submit();
    });
});