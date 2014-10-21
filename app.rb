require "sinatra"
require "omniauth"
require "omniauth-readability"
require "helpers/authorization_helper"

configure do
  set :inline_templates, true
  set :session_secret, ENV["SESSION_SECRET"]
  enable :sessions
end

use OmniAuth::Builder do
  provider :readability, ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"]
end

get "/" do
  if session[:credentials].nil?
    erb :root
  else
    redirect "/import"
  end
end

get "/import" do
  erb :import
end

get "/auth/:provider/callback" do
  # The result will look something like this:
  # sessions[:credentials] = { "token": "a-token", "secret": "the-secret" }
  session[:credentials] = request.env['omniauth.auth']["credentials"]
  redirect "/import"
end

post "/import" do
  #readbility= ReadabilityBookmarks.new(token: ENV["TOKEN"], secret: ENV["SECRET"])
  #bookmarks = SafariBookmarks.new.bookmarks
  #readbility.import_bulk bookmarks
end

get "/auth/failure" do
  erb :auth_failure
end

get "/auth/:provider/deauthorized" do
  erb :auth_deauthorized
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

@@ auth_failure
<h1>Authentication Failed</h1>
<h3>message:<h3> <pre>#{params}</pre>

@@ auth_deauthorized
<h1>Application deauthorized</h1>
<h3>message: "#{params[:provider]} has deauthorized this app.</h3>

@@ root
<a href='#{base_url}/auth/readability'>Login with Readability</a>

@@ import
<h1>Upload a XML Bookmark list</h1>
<p>
  You can generate the list by running
  <pre>/usr/bin/plutil -convert xml1 -o - ~/Library/Safari/Bookmarks.plist > ~/Desktop/bookmarks.xml</pre>
  in your terminal
</p>
