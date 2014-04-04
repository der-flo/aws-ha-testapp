require_relative 'app'
require 'sidekiq/web'

set :environment, ENV['RACK_ENV'].to_sym
disable :run, :reload

get '/' do
  # simulated expensive request
  sleep 1
  HardWorker.perform_async
  content_type 'text/plain'
  "Hello world from #{`hostname`.strip}!\nFoo bar baz."
end

run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)

