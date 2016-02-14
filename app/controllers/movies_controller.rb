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
      parser_result = parser.result

      if parser_result['Title'].nil?
        slim :'movies/no_results'
      else
        @movie = Movie.create(
          title: parser_result['Title'],
          year: parser_result['Year'],
          rated: parser_result['Rated'],
          released: parser_result['Released'],
          runtime: parser_result['Runtime'],
          genre: parser_result['Genre'],
          director: parser_result['Director'],
          writer: parser_result['Writer'],
          actors: parser_result['Actors'],
          plot: parser_result['Plot'],
          language: parser_result['Language'],
          country: parser_result['Country'],
          awards: parser_result['Awards'],
          poster: parser_result['Poster'],
          metascore: parser_result['Metascore'],
          imbd_rating: parser_result['imdbRating'],
          imbd_votes: parser_result['imbdVotes'],
          imbd_id: parser_result['imbdID'],
          film_type: parser_result['Type'],
          response: parser_result['Response'],
          error: parser_result['Error']
        )

        @movie.save

        slim :'movies/show'

      end
    end
  end

  not_found do
    status 404
    slim :'404'
  end
end
