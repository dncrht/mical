class AdminController < ApplicationController
  before_filter :who_am_i

  def who_am_i
  end
end
