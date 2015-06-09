class Event < ActiveRecord::Base
  validates :day, :activity_id, :description, :presence => true
  validates :day, :uniqueness => true

  belongs_to :activity

  scope :in_year, -> (year) { where('day >= ? AND day <= ?', "#{year}-01-01", "#{year}-12-31").order('day') }

  def self.replace(day, activity_id, description)
    return nil if day.blank?

    event = Event.find_by_day(day)
    if event.nil?
      event = Event.new
      event.day = day
    end
    event.activity_id = activity_id #there is only one activity per day
    event.description = description
    event.save

    event
  end

  def self.first_year
    Event.first.nil? ? Date.current.year : Event.first.day.year
  end

  def self.to_h(events)
    Hash[*events.map { |event| [event.day.to_s, event] }.flatten] #http://snippets.dzone.com/posts/show/302
  end
end
