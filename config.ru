require 'bundler/setup'
Bundler.require(:default)

# pull in the helpers and controllers
require_all 'services'
require_all 'controllers'

require_relative 'assets'

map '/assets' do
  run Assets.environment Sinatra::Application.settings.root
end

# map the controllers to routes
map('/') { run HomePageController }
