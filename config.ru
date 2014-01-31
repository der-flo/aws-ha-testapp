require 'sinatra'

set :environment, ENV['RACK_ENV'].to_sym
disable :run, :reload

get '/' do
  content_type 'text/plain'
  "Hello world from #{`hostname -f`.strip}!"
end

run Sinatra::Application
