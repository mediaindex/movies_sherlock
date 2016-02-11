class HomePageController < ApplicationController

  get '/' do
    slim :home_page
  end

  post '/' do
    @movie_title = params[:movie_title]
    if @movie_title.empty?
      @error = 'Oops, field is empty!'
      slim :home_page
    else
      parse
    end
  end

  not_found do
    status 404
    slim :page_not_found
  end
end
