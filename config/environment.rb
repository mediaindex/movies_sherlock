require 'bundler/setup'
Bundler.require(:default)

require 'carrierwave/orm/activerecord'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

CarrierWave.configure do |config|
  config.storage = :file
  config.root = File.join(APP_ROOT, 'public')
end

ActiveRecord::Base.raise_in_transactional_callbacks = true

require_all 'app'
