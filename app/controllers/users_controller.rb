class UsersController < ApplicationController
  before do
    current_user?
  end

  get '/:id' do
    @users = User.count
    @all_movies = Movie.count
    @unique_movies = Movie.uniq.count(:title)
    @popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
    @user_movies = current_user.movies.count
    @movies_search = Movie.user_search(current_user).sum(:search_count)
    slim :'users/index'
  end

  get '/:id/my_movies' do
    @user_movies = current_user.movies
    slim :'users/my_movies'
  end

  get '/:id/edit_profile' do
    show_user
    slim :'users/edit'
  end

  put '/:id' do
    show_user
    if @user.update_attributes(params[:user])
      redirect "/users/#{current_user.id}"
    else
      @errors = @user.errors.full_messages
      slim :'/users/edit'
    end
  end

  private

  def show_user
    @user = User.find(params[:id])
  end
end
