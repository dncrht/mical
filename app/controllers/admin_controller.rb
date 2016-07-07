class AdminController < ApplicationController
  before_action :require_login
  layout 'admin'

  def index; end

  private

  def self.access_to
    before_action :_access_to
    define_method :_access_to do
      return if yield(current_user)
      render plain: 'Forbidden', layout: true, status: 403
    end
  end

  def self.set_tab(tab)
    before_action :_set_tab
    define_method :_set_tab do
      @tab = tab
    end
  end
end
