module ApplicationHelper
  def pintar_calendario
    out = ''

    dia1 = Date.new(@año, 1, 1)
    año = @año


    wday = dia1.wday
    wday = 7 if wday == 0

    #días de cada mes
    dias_mes = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    if año % 4 == 0
      dias_mes[2] = 29 #los años múltiplos de 4, son bisiestos
    end

    12.times do |mes|

      out << "<table class='mes'><caption>#{@nombres_mes[mes + 1]}</caption>"
      out << '<tr><th>Lu</th><th>Ma</th><th>Mi</th><th>Ju</th><th>Vi</th><th>Sá</th><th>Do</th></tr><tr>'

      #deja tantos huecos como días del anterior mes sobraron
      (wday - 1).times { out << '<td></td>' }

      dias_mes[mes + 1].times do |dia|
        hoy = '%s-%02d-%02d' % [año, mes +1, dia + 1]

        out << %(<td data-dia="#{hoy}")

        titulo = []
        clase = []
        if @efemerides.kind_of? Hash and @efemerides.include? hoy
          clase << "activity#{@efemerides[hoy].actividad_id}"
          titulo << @efemerides[hoy].resumen if @logged_as.can_see_resumen
        end

        unless titulo.empty?
          out << %( title="#{titulo.join(', ')}")
        end

        unless clase.empty?
          out << %( class="#{clase.join(' ')}")
        end

        out << ">#{dia + 1}</td>"

        if wday == 7
          out << "</tr>\n<tr>"
          wday = 0
        end

        wday += 1

      end

      #rellena huecos como días faltan
      (8 - wday).times { out << '<td></td>' }

      out << "</tr></table>\n"
    end

    out.html_safe
  end
end
