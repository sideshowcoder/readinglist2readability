require 'sinatra'
require 'json'
require 'omniauth'
require 'omniauth-readability'

class ReadablityAuth < Sinatra::Base
  configure do
    set :inline_templates, true
    set :session_secret, "abc"
    enable :sessions
  end

  use OmniAuth::Builder do
    provider :readability, ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"]
  end

  get '/' do
    erb "<a href='http://localhost:4567/auth/readability'>Login with Readability</a>"
  end

  get '/auth/:provider/callback' do
    erb "<h1>#{params[:provider]}</h1>
         <pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"
  end

  get '/auth/failure' do
    erb "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
  end

  get '/auth/:provider/deauthorized' do
    erb "#{params[:provider]} has deauthorized this app."
  end
end

__END__

@@ layout
<html>
  <head>
    <link href='http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css' rel='stylesheet' />
  </head>
  <body>
    <div class='container'>
      <div class='content'>
        <%= yield %>
      </div>
    </div>
  </body>
</html>
