$LOAD_PATH.unshift(File.expand_path "../../lib", __FILE__)
$LOAD_PATH.unshift(File.expand_path "../../", __FILE__)

require "dotenv"
Dotenv.load
require 'bundler'
Bundler.setup

ENV["RACK_ENV"] = "test"

require "pry"
require "minitest/autorun"

