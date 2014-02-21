require 'bundler/setup'
require 'sinatra'

set :environment, ENV['RACK_ENV'].to_sym
disable :run, :reload

get '/' do
  # simulated expesive request
  sleep 1
  content_type 'text/plain'
  "Hello world from #{`hostname`.strip}!"
end

run Sinatra::Application
