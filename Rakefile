require "rake/testtask"
require "dotenv/tasks"

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
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

