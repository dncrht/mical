class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :email, :password, :can_download, :can_edit_activity, :can_edit_event, :can_see_legend, :can_see_description
  
  before_destroy :at_least_one_admin
  
  def at_least_one_admin
    raise 'Must be at least one admin' if is_admin and User.where(:is_admin => true).count == 1
  end
end
