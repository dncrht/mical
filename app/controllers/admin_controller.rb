class AdminController < ApplicationController
  before_filter :authorize

  def index; end

  private

  def self.access_to
    before_filter :_access_to
    define_method :_access_to do
      return if yield(current_user)
      render text: 'Forbidden', layout: true, status: 403
    end
  end

  def self.set_tab(tab)
    before_filter :_set_tab
    define_method :_set_tab do
      @tab = tab
    end
  end
end
