# encoding: UTF-8

module ApplicationHelper
  
  def print_month(year, month)
    out = ''

    day = Date.new(year, month, 1)

    week_day = day.wday
    week_day = 7 if week_day == 0

    # Print month name
    out << %(<table class="span3 month)
    out << ' current' if month == @today.month
    out << %(">\n<tr class="caption"><th colspan="7">#{l(day, :format => :month)}</th></tr>)
    
    # Print day of the week names
    out << %(<tr class="weekdays"><th>mon</th><th>tue</th><th>wed</th><th>thu</th><th>fri</th><th>sat</th><th>sun</th></tr>\n<tr>)

    # Leave as many blanks as last month's days are left
    (week_day - 1).times { out << '<td></td>' }

    # Iterate days
    day.end_of_month.day.times do
      today = day.to_s

      out << %(<td data-day="#{today}")

      html_classes = ['day']
      if @events.kind_of? Hash and @events.include? today
        html_classes << "activity#{@events[today].activity_id}"
        out << %( data-activity="#{@events[today].activity_id}")
        out << %( title="#{@events[today].description}") if signed_in? and current_user.can_see_description
      end

      html_classes << 'current' if day == @today

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
    (8 - week_day).times { out << '<td></td>' } if week_day > 1

    out << "</tr>\n"
    
    out << "</table>\n"

    out.html_safe
  end
  
  # Wrap a HTML block within a DIV, every X iterations
  # We can't redefine this as an Array method because Array can't access with_output_buffer
  # http://blog.agile-pandas.com/2011/01/13/rails-capture-vs-with-output-buffer
  # http://asciicasts.com/episodes/208-erb-blocks-in-rails-3
  def each_with_wrapper(object, per_row = 4, clazz = '') #the last &block) parameter is optional
    return if object.nil?

    out = ''
    i = 0
    object.each do |o|
      out << %(<div class="#{clazz}">) if i % per_row == 0
      out << with_output_buffer { yield o } #with_output_buffer(&block) : requires a block but our code needs i so we use block.call(i) , aka yield
      i += 1
      out << '</div>' if i % per_row == 0
    end
    out << '</div>' if i % per_row != 0
    
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
