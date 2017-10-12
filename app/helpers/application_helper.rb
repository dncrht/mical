module ApplicationHelper
  def current_user_account
    return 'guest' unless current_user
    current_user.email.split('@')[0]
  end

  def tick_or_x(bool)
    bool ? '✓' : '✗'
  end

  def activities_style(activities)
    activities.map do |i|
      ".activity#{i.id} {background: #{i.color};}"
    end.join("\n")
  end

  def react_applet(name, options = {})
    @js = {} if @js.blank?

    mount_point = "react-applet#{rand(100)}"

    @js[mount_point] = {name: name, options: options}

    content_tag(:div, nil, id: "js-#{mount_point}")
  end

  def render_react_applet(name, options, mount_point = nil)
    mount_point = mount_point || name.sub('Applet', '').downcase
    "renderApplet('js-#{mount_point}', {applet: #{name}, initialModel: #{options.to_json}});".html_safe
  end

  def render_react_applets
    return if @js.blank?
    components = @js.map do |mount_point, component|
      render_react_applet component[:name], component[:options], mount_point
    end

    content_tag(:script, components.join("\n").html_safe)
  end
end
