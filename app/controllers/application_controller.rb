class ApplicationController < Sinatra::Base

  enable :sessions
  set :session_secret, 'try to make this string long and hard to guess'

  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, '../views/') }

  not_found do
    status 404
    slim :'404'
  end

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      nil
    end
  end
end
