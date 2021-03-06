class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    ActionController::Base.helpers.asset_path('avatar.png')
  end

  def store_dir
    'uploads/users/avatars'
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
