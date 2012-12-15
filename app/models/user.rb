class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :email, :password, :can_download, :can_edit_activity, :can_edit_event, :can_see_legend, :can_see_description
end
