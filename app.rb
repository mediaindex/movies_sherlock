# Libraries

require 'sinatra'
require 'require_all'
require 'bundler'
Bundler.setup

# Application

class App < Sinatra::Base
  require_all 'helpers'
  use AssetHandler

  get '/' do
    slim :index
  end

  not_found do
    status 404
    erb '<h2 class="red">Oops, page not found!</h2>'
  end
end
