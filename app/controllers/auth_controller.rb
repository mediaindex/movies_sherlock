class AuthController < ApplicationController

  get '/sign_up' do
    slim :'auth/sign_up'
  end

  post '/sign_up' do
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect("/")
    else
      @errors = user.errors.full_messages
      slim :'auth/sign_up'
    end
  end
end
