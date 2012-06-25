ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if instance.error_message.kind_of?(Array)
    if html_tag[0..5] == '<label'
      html_tag.html_safe
    else
      %(#{html_tag}<span class="help-inline error">#{instance.error_message.join(',')}</span>).html_safe
    end
  else
    if html_tag[0..5] == '<label'
      html_tag.html_safe
    else
      %(#{html_tag}<span class="help-inline error">#{instance.error_message}</span>).html_safe
    end
  end
end