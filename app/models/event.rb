class Event < ActiveRecord::Base
  #set_primary_keys :day
  validates :day, :activity_id, :description, :presence => true
  
  attr_accessible :day, :activity_id, :description
  
  def self.replace(day, activity_id, description)
    return nil if day.blank?

    e = Event.find_by_day(day)
    if e.nil?
      e = Event.new #TODO .create doesn't work?
      e.day = day
    end
    e.activity_id = activity_id #there is only one activity per day
    e.description = description
    e.save
    
    e
  end
end
