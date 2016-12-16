class NavigationCell < Cell::ViewModel
  include Rails.application.routes.url_helpers

  def current_tab(this_tab = nil)
    (tab == this_tab) ? 'active' : nil
  end

  def tab
    options[:tab]
  end

  def user
    model
  end
end
