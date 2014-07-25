s3 = YAML::load(File.open(File.join(Rails.root, 'config', 's3.yml')))[Rails.env]

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: s3['access_key_id'],
    aws_secret_access_key: s3['secret_access_key']
  }
  config.fog_directory = s3['bucket']
  config.fog_public = true

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
