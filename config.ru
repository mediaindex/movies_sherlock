# config.ru

require 'bundler'
Bundler.require :default

require 'sinatra/base'

# pull in the helpers and controllers
require_all 'helpers'
require_all 'controllers'

unless ENV['RACK_ENV'] == 'production'
  map '/assets' do
    run AssetsHelper.environment Sinatra::Application.settings.root
  end
end

# map the controllers to routes
map('/') { run HomePageController }
