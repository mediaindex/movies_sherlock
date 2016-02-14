class MoviesController < ApplicationController

  get '/' do
    slim :'movies/index'
  end

  post '/' do
    @movie_title = params[:movie_title]
    if @movie_title.empty?
      @error = 'Oops, field is empty!'
      slim :'movies/index'
    else
      parser = ParserService.new 
      parser.find_movie(@movie_title)
      
      slim :'movies/show', :locals => { results: parser.result }
    end
  end

  not_found do
    status 404
    slim :'404'
  end
end
