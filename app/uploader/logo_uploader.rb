class LogoUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png)
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
