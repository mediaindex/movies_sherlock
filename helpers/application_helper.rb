module ApplicationHelper

  def parse
    api_result = RestClient.get "http://www.omdbapi.com/?t=" + "#{@movie_title}" + "&y=&plot=full&r=JSON"
    jhash = JSON.parse(api_result)
    output = ''

    jhash.each do |key, value|
      if key == 'Poster'
        output << "<tr><td>#{key}</td><td><img src=\"#{value}\" alt=\"Movie poster\" height=\"50%\" width=\"auto\"></td></tr>"
      else
        output << "<tr><td>#{key}</td><td>#{value}</td></tr>"
      end
    end

    slim :result_page, :locals => { results: output }
  end
end
