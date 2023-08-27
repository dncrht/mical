class MonthCell < Cell::ViewModel
  include Rails.application.routes.url_helpers

  def table
    out = ''

    day = start_day

    week_day = day.wday
    week_day = 7 if week_day == 0

    # Leave as many blanks as last month's days are left
    (week_day - 1).times { out << '<td class="month-day_blank"></td>' }

    # Iterate days
    day.end_of_month.day.times do
      out << %(<td data-day="#{day.to_s}" #{day_attributes(day.to_s)}>)

      if show_desc
        out << link_to(day.day, event_path(id: day.to_s), 'data-controller' => 'modal') << '</td>'
      else
        out << "#{day.day}</td>"
      end

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

    out
  end

  def month_class
    return 'month month_current' if month == today.month && year == today.year
    'month'
  end

  def day_attributes(day)
    out = []
    clazz = 'month-day'
    style = ''

    if events.has_key?(day)
      style = background(events[day].activities)
      clazz << ' activity'
      #out << %(data-activity="#{events[day].activity_id}")
      rating = events[day].rating.to_i.zero? ? nil : "#{events[day].rating}★\n"
      out << %(title="#{rating}#{events[day].description}") if show_desc
    end

    clazz << ' month-day_current' if day == today.to_s
    out << %(class="#{clazz}" data-toggle="tooltip" style="#{style}")

    out.join(' ')
  end

  def start_day
    Date.new(year, month, 1)
  end

  def year
    options[:year]
  end

  def month
    options[:month]
  end

  def events
    options[:events]
  end

  def today
    options[:today]
  end

  def show_desc
    options[:show_desc]
  end

  def background(activities)
    if activities.size == 1
      return "background: #{activities.first.color}"
    end

    "background: linear-gradient(to right, #{activities.map(&:color).join(', ')})"
  end
end
