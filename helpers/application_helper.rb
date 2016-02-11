module ApplicationHelper

  def css(*stylesheets)
    stylesheets.map do |stylesheet| 
      "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end

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
