class UsersController < ApplicationController
  get '/search_history' do
    if current_user
      @users = User.count
      @all_movies = Movie.count
      @unique_movies = Movie.uniq.count(:title)
      @popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
      @user_movies = @user.movies.count
      @movies_search = Movie.user_search(current_user).sum(:search_count)
      slim :'users/index'
    else
      redirect("/auth/log_in")
    end
  end

  get '/my_movies' do
    if current_user
      @user_movies = @user.movies
      slim :'users/my_movies'
    else
      redirect("/auth/log_in")
    end
  end
end
