class Event < ApplicationRecord
  validates :day, :activity_id, :description, :presence => true
  validates :day, :uniqueness => true
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}, allow_nil: true

  belongs_to :activity
  has_many :assets

  scope :in_year, -> (year) { where('day >= ? AND day <= ?', "#{year}-01-01", "#{year}-12-31").order('day') }

  def self.first_year
    Event.first.nil? ? Date.current.year : Event.first.day.year
  end

  def self.to_h(events)
    Hash[*events.map { |event| [event.day.to_s, event] }.flatten] #http://snippets.dzone.com/posts/show/302
  end
end
