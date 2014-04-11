require 'bundler/setup'
require 'sinatra'
require 'sidekiq'
require 'open-uri'
require 'aws-sdk'

require_relative 'config'
Sidekiq.configure_server { |config| config.redis = { url: REDIS_URL} }
Sidekiq.configure_client { |config| config.redis = { url: REDIS_URL, size: 1 } }

class HardWorker
  include Sidekiq::Worker
  def perform
    sleep 10
  end
end

# bundle exec sidekiq -r ./app.rb -c 3
