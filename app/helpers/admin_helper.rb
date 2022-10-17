module AdminHelper
  def alert_with_effect
    id = SecureRandom.uuid
    content_tag :div, id: "js-alert-with-effect-#{id}" do
      concat content_tag :script, "setTimeout(function() {document.getElementById('js-alert-with-effect-#{id}').remove()}, 3000)".html_safe
      yield
    end
  end

  def tick_or_x(bool)
    bool ? '✓' : '✗'
  end
end
