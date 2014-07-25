class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

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
