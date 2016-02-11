class HomePageController < ApplicationController
  get '/' do
    slim :home_page
  end

  not_found do
    status 404
    erb '<h2 class="red">Oops, page not found!</h2>'
  end
end
