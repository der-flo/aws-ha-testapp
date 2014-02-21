require_relative 'app'
require 'sidekiq/web'

set :environment, ENV['RACK_ENV'].to_sym
disable :run, :reload

get '/' do
  # simulated expensive request
  sleep 1
  HardWorker.perform_async(5)
  content_type 'text/plain'
  "Hello world from #{`hostname`.strip}!"
end

run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)

