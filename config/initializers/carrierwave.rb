if Rails.env.production?
  CarrierWave.configure do |config|
    config.cache_dir = "#{Rails.root}/tmp/"
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => "#{ENV['AWS_ACCESS_KEY_ID']}",       # required
      :aws_secret_access_key  => "#{ENV['AWS_SECRET_ACCESS_KEY']}" ,       # required
      :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = "#{ENV['VIDEOMARKETING_AWS_S3_BUCKET_NAME']}"                     # required
    config.asset_host       = "https://#{ENV['VIDEOMARKETING_AWS_S3_BUCKET_NAME']}.s3.amazonaws.com"            # optional, defaults to nil
    config.fog_public     = true                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
elsif Rails.env.development?
  CarrierWave.configure do |config|
    config.cache_dir = "#{Rails.root}/tmp/"
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => "#{ENV['AWS_ACCESS_KEY_ID']}",       # required
      :aws_secret_access_key  => "#{ENV['AWS_SECRET_ACCESS_KEY']}" ,       # required
      :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = "#{ENV['VIDEOMARKETING_AWS_S3_BUCKET_NAME']}"                     # required
    config.asset_host       = "https://#{ENV['VIDEOMARKETING_AWS_S3_BUCKET_NAME']}.s3.amazonaws.com"            # optional, defaults to nil
    config.fog_public     = true                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
elsif Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end