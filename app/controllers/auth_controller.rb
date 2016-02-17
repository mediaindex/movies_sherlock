class AuthController < ApplicationController
  get '/log_in' do
    slim :'auth/log_in'
  end

  post '/log_in' do
    email = params[:user][:email]
    password = params[:user][:password]
    if email.empty? || password.empty?
      @error = 'Please, fill all the fields.'
      slim :'auth/log_in'
    else
      user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

      if user
        session[:user_id] = user.id
        redirect("/")
      else
        @error = 'Username not found or password incorrect.'
        slim :'auth/log_in'
      end
    end
  end

  get '/log_out' do
    session[:user_id] = nil
    redirect("/")
  end

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
