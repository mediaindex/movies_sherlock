class UsersController < ApplicationController
  get '/:id' do
    if current_user
      User.find(params[:id])
      @users = User.count
      @all_movies = Movie.count
      @unique_movies = Movie.uniq.count(:title)
      @popular_movie = Movie.group(:title).order('title DESC').limit(7).count(:id)
      slim :'users/index'
    else
      redirect("/auth/log_in")
    end
  end
end
