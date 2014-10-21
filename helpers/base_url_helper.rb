require "sinatra/base"

module Sinatra
  module BaseUrlHelper
    def base_url
      "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end
  end

  helpers BaseUrlHelper
end
