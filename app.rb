require "sinatra"
require "omniauth"
require "omniauth-readability"
require "bookmark_list"
require "readability_importer"

helpers do
  def base_url
    "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end

  def authorized?
    !session[:credentials].nil?
  end
end

before "/import" do
  halt(401, "Not authorized") unless authorized?
end

configure do
  set :inline_templates, true
  set :session_secret, ENV["SESSION_SECRET"]
  enable :sessions
end

use OmniAuth::Builder do
  provider :readability, ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"]
end

get "/?" do
  if !authorized?
    erb :index
  else
    redirect "/import"
  end
end

get "/signout" do
  session.clear
  redirect "/"
end

get "/import" do
  erb :import
end

post "/import"  do
  raw_bookmarks = params[:file][:tempfile].read.force_encoding("UTF-8")
  bookmark_list = BookmarkList.create_from_xml_export(raw_bookmarks)
  importer = ReadabilityImporter.new(session[:credentials], bookmark_list)
  @result = importer.import
  erb :report
end


get "/auth/:provider/callback" do
  # The result will look something like this:
  # sessions[:credentials] = { "token": "a-token", "secret": "the-secret" }
  session[:credentials] = request.env['omniauth.auth']["credentials"]
  redirect "/import"
end

get "/auth/failure" do
  erb :auth_failure
end

get "/auth/:provider/deauthorized" do
  erb :auth_deauthorized
end

