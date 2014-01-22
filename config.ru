$LOAD_PATH.unshift(File.dirname(__FILE__))

require "dotenv"
Dotenv.load

require "bundler/setup"
require "auth_app"

run ReadablityAuth
