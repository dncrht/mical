module EventsHelper
  def rating(value, top)
    content_tag :p, class: 'event-form-rating', data: {controller: 'rating'} do
      top.times do |i|
        concat content_tag(:span, value <= i ? '☆' : '★', title: "#{value}/#{top}", data: {number: i + 1, 'rating-target': 'star', action: 'click->rating#rate'})
      end
      concat content_tag(:input, nil, type: "hidden", name: "event[rating]", value: value, data: {'rating-target': 'value'})
    end
  end
end
