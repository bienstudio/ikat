class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    ActionController::Base.helpers.asset_path('loading.png')
  end

  def store_dir
    'stores/logos'
  end

  def cache_dir
    '/tmp/uploads'
  end

  version :large do
    process resize_to_limit: [1000, 1000]
  end

  version :medium do
    process resize_to_limit: [500, 500]
  end

  version :small do
    process resize_to_limit: [250, 250]
  end
end
