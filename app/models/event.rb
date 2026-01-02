class Event < ApplicationRecord
  TOP = 10

  attr_accessor :activities_ids

  validates :day, :description, presence: true
  validates :day, uniqueness: true
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: TOP}, allow_nil: true
  validate :activities_present

  has_many :event_activities
  has_many :activities, through: :event_activities

  has_many :photos

  scope :in_year, ->(year) { where('day >= ? AND day <= ?', "#{year}-01-01", "#{year}-12-31").order('day') }

  after_commit :manage_event_activities

  def self.to_h(events)
    Hash[*events.map { |event| [event.day.to_s, event] }.flatten] #http://snippets.dzone.com/posts/show/302
  end

  def activities_present
    errors.add(:activities_ids, 'must select at least one') unless activities_ids.any?(&:present?)
  end

  def manage_event_activities
    chosen_activities = activities_ids.select(&:present?).map(&:to_i).sort
    existing_activities = activities.map(&:id).sort

    return if chosen_activities == existing_activities

    event_activities.where(activity_id: existing_activities - chosen_activities).destroy_all

    (chosen_activities - existing_activities).each do |id|
      event_activities.create activity_id: id
    end
  end
end
