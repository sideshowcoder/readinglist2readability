require "rake/testtask"
require "dotenv/tasks"
require "mkmf"

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
end

namespace :deploy do
  desc "export the .env file to heroku"
  task :setup_environment_variables do
    unless find_executable "heroku"
      puts "missing heroku executable"
      return
    end

    File.readlines(".env").map(&:strip).each do |value|
      sh "heroku config:set #{value}"
    end
  end
end

namespace :development do
  desc "spin up a development server"
  task :server do
    sh "bundle exec shotgun --server thin --env development --port 3000"
  end

  desc "run a console with the application loaded"
  task :console => :dotenv do
    require 'bundler'
    Bundler.setup

    $LOAD_PATH.unshift(File.expand_path "../lib", __FILE__)
    $LOAD_PATH.unshift(File.expand_path "../", __FILE__)
    ENV["RACK_ENV"] ||= "development"

    require "app"

    require "irb"
    ARGV.clear
    IRB.start
  end
end

