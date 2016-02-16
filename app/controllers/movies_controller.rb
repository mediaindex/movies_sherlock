class MoviesController < ApplicationController

  get '/' do
    slim :'movies/index'
  end

  post '/' do
    @movie_title = params[:movie_title]

    if @movie_title.empty?
      @error = 'Oops, nothing to search!'
      slim :'movies/index'

    elsif @movie_title.match(/[\p{L}&&[^a-zA-Z]]/)
      @error = 'Please, use only ASCII characters.'
      slim :'movies/index'

    else
      parser = ParserService.new 
      parser.find_movie(@movie_title)
      parser_result = parser.result

      if parser_result['Title'].nil?
        slim :'movies/no_results'

      elsif Movie.where(title: parser_result['Title']).present?
        movie = Movie.find_by(title: parser_result['Title'])
        @movie_id = movie.id
        slim :'movies/already_exists'

      else
        @movie = Movie.new(parser.prepare_to_model)

        if @movie.save
          slim :'movies/show'
        else
          @error = 'Something goes wrong!'
        end
      end
    end
  end

  get '/:id' do
    if current_user
      @movie = Movie.find(params[:id])
      slim :'movies/film_in_history'
    else
      redirect("/auth/log_in")
    end
  end
end
