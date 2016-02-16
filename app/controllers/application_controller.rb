class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, '../views/') }

  not_found do
    status 404
    slim :'404'
  end
end
