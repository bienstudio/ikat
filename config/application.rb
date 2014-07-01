require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Ikat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.paths.add 'lib/ikat', glob: '**/*.rb'
    config.autoload_paths += %W(#{config.root}/lib)

    config.assets.paths << "#{Rails.root}/app/assets/css"
    config.assets.paths << "#{Rails.root}/app/assets/img"
    config.assets.paths << "#{Rails.root}/app/assets/jsc"
    config.assets.paths << "#{Rails.root}/app/assets/webfonts"

    config.compass.require 'susy'

    config.action_controller.include_all_helpers = true

    config.paperclip_defaults = {
      storage:       :s3,
      url:           ':s3_alias_url',
      s3_credentials: File.join(Rails.root, 'config', 's3.yml'),
      s3_host_alias:  "s3.amazonaws.com/ikat_#{Rails.env}"
    }
  end
end
