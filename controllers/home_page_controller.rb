class HomePageController < ApplicationController
  get '/' do
    api_result = RestClient.get 'http://www.omdbapi.com/?t=gatsby&y=&plot=full&r=JSON'
    jhash = JSON.parse(api_result)
    output = ''

    jhash.each do |key, value|
      output << "<tr><td>#{key}</td><td>#{value}</td></tr>"
    end

    slim :home_page, :locals => {results: output }
  end

  not_found do
    status 404
    erb '<h2 class="red">Oops, page not found!</h2>'
  end
end
