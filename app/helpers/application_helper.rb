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

  def react_component(name, options = {})
    @js = {} if @js.blank?

    mount_point = "react_component#{rand(100)}"

    @js[mount_point] = {name: name, options: options}

    content_tag(:div, nil, id: mount_point)
  end

  def render_react_components
    return if @js.blank?
    components = @js.map do |mount_point, component|
      "renderApplet('#{mount_point}', {applet: #{component[:name]}, initialModel: #{component[:options].to_json}});"
    end

    content_tag(:script, components.join("\n").html_safe)
  end
end
