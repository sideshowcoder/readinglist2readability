require "sinatra/base"

module Sinatra
  module AuthorizationHelper
    def authorized?
      session[:credentials].nil?
    end
  end

  helpers AuthorizationHelper
end
