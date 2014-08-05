if development?
  require 'better_errors'
  require 'sinatra/reloader'
  require 'log_buddy'
end

IKAT_ROOT ||= File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', '..')

module Ikat
  # Version 1 of the Ikat API.
  class API < Sinatra::Base
    configure :development do
      register Sinatra::Reloader

      also_reload "#{IKAT_ROOT}/app/**/*.rb"
      also_reload "#{IKAT_ROOT}/lib/**/*.rb"

      use BetterErrors::Middleware

      BetterErrors.application_root = File.expand_path('..', __FILE__)
    end

    Rabl.register!

    set :client_token, '40c18ba2229c9e30aa41d65da5c1a77753d7953fda8c09bfecd721317ed9f795afd4cb5cd9dc3ea1e85222f62a2ce4477858f8334d5d3885b4fcfc652934204c'
    set :views, File.join(IKAT_ROOT, 'app', 'api', 'ikat', 'views')

    Rabl.configure do |config|
      config.json_engine        = Oj
      config.include_child_root = false
    end

    # API requires Mutations to carry out actions
    Dir[File.join(IKAT_ROOT, 'lib', 'ikat', '**', '*.rb')].each do |f|
      require f
    end

    enable :raise_errors
    disable :show_exceptions

    set :haml, escape_html: true

    before do
      content_type :json
    end

    Dir[File.join(IKAT_ROOT, 'app', 'api', '**', '*.rb')].each do |file|
      require file
    end
  end
end
