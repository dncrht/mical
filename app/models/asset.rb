class Asset < ActiveRecord::Base
  dragonfly_accessor :image
  validates_presence_of :image

  belongs_to :event

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
