class Event < ActiveRecord::Base
  validates :day, :activity_id, :description, :presence => true
  validates :day, :uniqueness => true

  belongs_to :activity

  scope :in_year, -> (year) { where('day >= ? AND day <= ?', "#{year}-01-01", "#{year}-12-31").order('day') }

  def self.replace(day, activity_id, description)
    return nil if day.blank?

    e = Event.find_by_day(day)
    if e.nil?
      e = Event.new
      e.day = day
    end
    e.activity_id = activity_id #there is only one activity per day
    e.description = description
    e.save

    e
  end

  def self.first_year
    Event.first.nil? ? Date.current.year : Event.first.day.year
  end

  def to_s
    %(#{day},"#{activity.name}","#{description.strip}")
  end

  def self.to_h(events)
    Hash[*events.map { |event| [event.day.to_s, event] }.flatten] #http://snippets.dzone.com/posts/show/302
  end
end
