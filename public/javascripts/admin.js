$(document).ready(function(){
    $('.alert-message').append('<a href="#" class="close">×</a>');

    $('.close').live('click', function(){
        $(this).parent().fadeOut();
    });

    $('.help-inline').closest('.clearfix').addClass('error');
});