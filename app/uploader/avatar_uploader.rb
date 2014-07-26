class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def default_url
    ActionController::Base.helpers.asset_path('avatar.png')
  end

  version :large do
    process resize_to_fill: [1000, 1000]
  end

  version :medium do
    process resize_to_fill: [500, 500]
  end

  version :small do
    process resize_to_fill: [250, 250]
  end
end
