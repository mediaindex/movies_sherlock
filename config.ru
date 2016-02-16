require_relative './config/environment'

map '/app/assets' do
  environment = Sprockets::Environment.new
  environment.append_path './app/assets'
  run environment
end

map('/') { run MoviesController }
map('/movies') { run MoviesController }
map('/auth') { run AuthController }
