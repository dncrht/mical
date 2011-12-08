$(document).ready(function(){
    $('td').mouseover(function(){
        if ($(this).html() != '') {
            var m = $(this).parents('table').children('caption').html();
            $('h1').html( $(this).html() + ' de ' + m );
        }
    });
    $('td').click(function(){
        var dia = $(this).attr('data-dia');
        actividad = prompt('Actividad (1 a 4) realizada el ' + dia);
        if (actividad == null || actividad == '') return;
        resumen = prompt('Resumen del ' + dia);
        if (resumen == null || resumen == '') return;
        $('#hoy').val(dia + "\t" + actividad + "\t" + resumen);
        document.forms[0].submit();
    });
});