$LOAD_PATH.unshift(File.expand_path "../lib", __FILE__)
$LOAD_PATH.unshift(File.expand_path "../", __FILE__)

ENV["RACK_ENV"] ||= "development"

# load the environment for development and testing
if ENV["RACK_ENV"] != "production"
  require "dotenv"
  Dotenv.load
end

require "app"
run Sinatra::Application
