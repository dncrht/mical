module ApplicationHelper
  include Sal::ApplicationHelper

  def activities_style(activities)
    activities.map do |i|
      ".activity#{i.id} {background: #{i.color};}"
    end.join("\n")
  end
end
