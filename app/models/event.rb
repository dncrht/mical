class Event < ActiveRecord::Base
  validates :day, :activity_id, :description, :presence => true
  validates :day, :uniqueness => true

  belongs_to :activity

  scope :in_year, -> (year) { where('day >= ? AND day <= ?', "#{year}-01-01", "#{year}-12-31").order('day') }

  def self.first_year
    Event.first.nil? ? Date.current.year : Event.first.day.year
  end

  def to_s
    %(#{day},"#{activity.name}","#{description.strip}")
  end

  def self.to_h(events)
    Hash[*events.map { |event| [event.day.to_s, event] }.flatten] #http://snippets.dzone.com/posts/show/302
  end

  def url
    Dragonfly.app.remote_url_for(image_uid)
  end

  # Creates an Asset from params if it's a local upload
  # or from a URL if it was uploaded to S3.
  # image_url is named "singular" but can contain a list of urls.
  def self.create_from_params(params)
    if params.include? :image_url
      params[:image_url].split(',').each do |image_url|
        self.create(image_url: image_url)
      end
    else
      self.create(params)
    end
  end
end
