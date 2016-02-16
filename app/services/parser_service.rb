class ParserService
   attr_reader :result

   def initialize 
     @result = []
   end  

   def find_movie(movie_title)
     @result = prepare_data(movie_title)
   end

   def prepare_to_model
     {
       title: result['Title'],
       year: result['Year'],
       rated: result['Rated'],
       released: result['Released'],
       runtime: result['Runtime'],
       genre: result['Genre'],
       director: result['Director'],
       writer: result['Writer'],
       actors: result['Actors'],
       plot: result['Plot'],
       language: result['Language'],
       country: result['Country'],
       awards: result['Awards'],
       poster: result['Poster'],
       metascore: result['Metascore'],
       imbd_rating: result['imdbRating'],
       imbd_votes: result['imbdVotes'],
       imbd_id: result['imbdID'],
       film_type: result['Type'],
       response: result['Response'],
       error: result['Error']
     }
   end

   private 

   def prepare_data(movie_title) 
     api_result = RestClient.get "http://www.omdbapi.com/?t=" + movie_title + "&y=&plot=full&r=JSON"
     JSON.parse(api_result)
   end
end
