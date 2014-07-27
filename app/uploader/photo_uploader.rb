class PhotoUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    ActionController::Base.helpers.asset_path('loading.png')
  end

  version :large do
    process resize_to_limit: [1000, 100000]
  end

  version :medium do
    process resize_to_limit: [500, 100000]
  end

  version :small do
    process resize_to_limit: [250, 100000]
  end
end
