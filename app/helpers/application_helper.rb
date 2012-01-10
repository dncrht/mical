module ApplicationHelper
  def compose_calendar
    out = ''

    day1 = Date.new(@año, 1, 1)
    year = @año

    week_day = day1.wday
    week_day = 7 if week_day == 0

    #number of days of each month
    days_month = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    if year % 4 == 0
      days_month[2] = 29 #los años múltiplos de 4, son bisiestos
    end

    12.times do |month|

      out << '<div class="clearfix">' if month % 4 == 0

      out << %(<table class="month)
      out << ' current' if (month + 1) == @today.month
      out << %("><tr class="caption"><th colspan="7">#{@nombres_mes[month + 1]}</th></tr>)
      out << '<tr class="weekdays"><th>lu</th><th>ma</th><th>mi</th><th>ju</th><th>vi</th><th>sá</th><th class="last">do</th></tr><tr>'

      #we left as many blanks as last month's days are left
      (week_day - 1).times { out << '<td></td>' }

      days_month[month + 1].times do |day|
        hoy = '%s-%02d-%02d' % [year, month +1, day + 1]

        out << %(<td data-day="#{hoy}")

        classes = ['day']
        if @efemerides.kind_of? Hash and @efemerides.include? hoy
          classes << "activity#{@efemerides[hoy].actividad_id}"
          out << %( data-activity="#{@efemerides[hoy].actividad_id}")
          out << %( title="#{@efemerides[hoy].resumen}") if @logged_as.can_see_resumen
        end

        classes << 'current' if (day + 1) == @today.day and (month + 1) == @today.month

        unless classes.empty?
          out << %( class="#{classes.join(' ')}")
        end

        out << ">#{day + 1}</td>"

        if week_day == 7
          out << "</tr>\n<tr>"
          week_day = 0
        end

        week_day += 1

      end

      #we fill with as many blanks as days are left
      (8 - week_day).times { out << '<td></td>' }

      out << "</tr></table>\n"

      out << '</div>' if (month + 1) % 4 == 0
    end
    out << '</div>'

    out.html_safe
  end

  # Cose un bloque en DIVs, cada X iteraciones
  # No podemos redefinirlo como un método de Array ya que no tiene disponible with_output_buffer
  # http://blog.agile-pandas.com/2011/01/13/rails-capture-vs-with-output-buffer
  # http://asciicasts.com/episodes/208-erb-blocks-in-rails-3
  def each_with_wrapper(object, per_row=4, clazz='') #el último parámetro &block) es opcional
    return if object.nil?

    out = ''
    i = 0
    object.each do |o|
      out << %(<div class="#{clazz}">) if i % per_row == 0
      out << with_output_buffer { yield o } #with_output_buffer(&block) : requiere un bloque pero nuestro código necesita i así que usamos block.call(i) oséase, yield
      i += 1
      out << '</div>' if i % per_row == 0
    end
    out << '</div>' if i % per_row != 0
    
    out.html_safe
  end
end
