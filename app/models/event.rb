class Event < ActiveRecord::Base
  set_primary_keys :day
  validates :day, :activity_id, :description, :presence => true
end
