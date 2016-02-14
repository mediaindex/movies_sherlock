class ParserService
   attr_reader :result

   def initialize 
     @result = []
   end  

   def find_movie(movie_title)
     @result = prepare_data(movie_title)
   end

   private 

   def prepare_data(movie_title) 
     api_result = RestClient.get "http://www.omdbapi.com/?t=" + movie_title + "&y=&plot=full&r=JSON"
     JSON.parse(api_result)
   end
end
