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

      out << %(<table class="month)
      out << ' current' if (month + 1) == @today.month
      out << %("><caption>#{@nombres_mes[month + 1]}</caption>)
      out << '<tr><th>lu</th><th>ma</th><th>mi</th><th>ju</th><th>vi</th><th>sá</th><th>do</th></tr><tr>'

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

        classes << 'current' if day == @today.day and (month + 1) == @today.month

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
    end

    out.html_safe
  end
end
