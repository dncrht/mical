# encoding: UTF-8

module ApplicationHelper

  def print_month(year, month)
    out = ''

    day = Date.new(year, month, 1)

    week_day = day.wday
    week_day = 7 if week_day == 0

    # Print month name
    out << %(<table class="span3 month)
    out << ' month_current' if month == @today.month
    out << %(">\n<tr><th class="month-header" colspan="7">#{l(day, :format => :month)}</th></tr>)

    # Print day of the week names
    out << %(<tr class="month-weekdays"><th>mon</th><th>tue</th><th>wed</th><th>thu</th><th>fri</th><th>sat</th><th>sun</th></tr>\n<tr>)

    # Leave as many blanks as last month's days are left
    (week_day - 1).times { out << '<td class="month-day_blank"></td>' }

    # Iterate days
    day.end_of_month.day.times do
      today = day.to_s

      out << %(<td data-day="#{today}")

      html_classes = ['month-day js-day-click']
      if @events.is_a?(Hash) && @events.include?(today)
        html_classes << "activity#{@events[today].activity_id}"
        out << %( data-activity="#{@events[today].activity_id}")
        out << %( title="#{@events[today].description}") if signed_in? && current_user.can_see_description
      end

      html_classes << 'month-day_current' if day == @today

      unless html_classes.empty?
        out << %( class="#{html_classes.join(' ')}")
      end

      out << ">#{day.day}</td>"

      if day.wday == 0
        if day < day.end_of_month
          out << "</tr>\n<tr>"
        end
      end

      day += 1
    end

    week_day = day.wday
    week_day = 7 if week_day == 0

    # Fill with blank days unless the month ends in last day of the week
    (8 - week_day).times { out << '<td class="month-day_blank"></td>' } if week_day > 1

    out << "</tr>\n"

    out << "</table>\n"

    out.html_safe
  end

  def show_errors(entity)
    if entity.errors.any?
      %(<div class="alert alert-error error">#{entity.errors.to_a.join('<br>')}</div>).html_safe
    end
  end

  def current_user_account
    current_user.email.split('@')[0] rescue 'guest'
  end

  def current_tab(this_tab = nil)
    (@tab == this_tab) ? 'active' : nil
  end

  def tick_or_x(bool)
    bool ? '✓' : '✗'
  end
end
