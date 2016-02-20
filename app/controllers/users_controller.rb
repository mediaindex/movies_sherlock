class UsersController < ApplicationController
  before do
    current_user?
  end

  get '/search_history' do
    @users = User.count
    @all_movies = Movie.count
    @unique_movies = Movie.uniq.count(:title)
    @popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
    @user_movies = @user.movies.count
    @movies_search = Movie.user_search(current_user).sum(:search_count)
    slim :'users/index'
  end

  get '/my_movies' do
    @user_movies = @user.movies
    slim :'users/my_movies'
  end
end
