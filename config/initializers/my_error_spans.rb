ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  message = if instance.error_message.respond_to? :join
    instance.error_message.join(', ')
  else
    instance.error_message
  end

  if html_tag =~ /class="checkbox"/ || (!(html_tag =~ /type="checkbox"/) && !(html_tag =~ /label/))
    %(#{html_tag}<span class="help-block help-error">⤷ #{message}</span>).html_safe
  else
    html_tag.html_safe
  end
end
