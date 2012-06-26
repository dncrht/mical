class Event < ActiveRecord::Base
  #set_primary_keys :day
  validates :day, :activity_id, :description, :presence => true
  
  attr_accessible :day, :activity_id, :description
end
