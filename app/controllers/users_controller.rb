class UsersController < ApplicationController
  get '/:id' do
    if current_user
      User.find(params[:id])
      @user = User.count
      @movie = Movie.count
      slim :'users/index'
    else
      redirect("/auth/log_in")
    end
  end
end
