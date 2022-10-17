require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret Rails.application.secrets.secret_key_base

  url_format "/media/:job/:name"

  case Rails.env
  when 'development'
    verify_urls false
    datastore :file,
      root_path: Rails.root.join('public/system'),
      server_root: Rails.root.join('public')
  when 'test'
    datastore :memory
  else
    datastore :s3,
      bucket_name: ENV['S3_BUCKET'],
      access_key_id: ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      region: 'eu-west-1',
      fog_storage_options: {path_style: true}
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
