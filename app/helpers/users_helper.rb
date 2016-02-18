def site_statistics
  @users = User.count
  @all_movies = Movie.count
  @unique_movies = Movie.uniq.count(:title)
  @popular_movie = Movie.group(:title).order('id DESC').limit(5).count(:id)
end


def user_statistics
  @my_movies = Movie.where(user_id: current_user.id).count
  @movies_search = Movie.where(user_id: current_user.id).sum(:search_count)
end
