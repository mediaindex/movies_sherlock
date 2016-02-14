class ParserService
   attr_reader :result

   def initialize 
     @result = ''
   end  

   def find_movie(movie_title)

     data = prepare_data(movie_title)

     data.each do |key, value|
       if key == 'Poster'
         result << "<tr><td>#{key}</td><td><img src=\"#{value}\" alt=\"Movie poster\" height=\"50%\" width=\"auto\"></td></tr>"
       else
         result << "<tr><td>#{key}</td><td>#{value}</td></tr>"
       end
     end  
   end

   private 

   def prepare_data(movie_title) 
     api_result = RestClient.get "http://www.omdbapi.com/?t=" + movie_title + "&y=&plot=full&r=JSON"
     JSON.parse(api_result)
   end
end
