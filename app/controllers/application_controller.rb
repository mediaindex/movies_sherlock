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
      User.find(session[:user_id])
    else
      nil
    end
  end

  def current_user?
    unless current_user
      redirect '/auth/log_in'
    end
  end
end
