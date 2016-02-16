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

      elsif Movie.where(title: parser_result['Title']).present? && current_user
        @movie = Movie.find_by(title: parser_result['Title'])
        @movie_id = @movie.id
        slim :'movies/show_from_db'

      elsif current_user
        @movie = Movie.new(parser.prepare_to_model)

        if @movie.save
          slim :'movies/show_from_db'
        else
          @error = 'Something goes wrong!'
        end

      else
        result = ''
        parser_result.each do |key, value|
          if key == 'Poster'
            result << "<tr><td>#{key}</td><td><img src=\"#{value}\" alt=\"Movie poster\"></td></tr>"
          else
            result << "<tr><td>#{key}</td><td>#{value}</td></tr>"
          end
        end
        slim :'movies/show', :locals => { results: result }
      end
    end
  end
end
