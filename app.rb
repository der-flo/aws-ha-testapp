require 'bundler/setup'
require 'sinatra'
require 'sidekiq'
require 'open-uri'
require 'aws-sdk'

ec2 = AWS::EC2.new.regions['eu-west-1']
instance_id = open('http://169.254.169.254/latest/meta-data/instance-id').read
instance = ec2.instances[instance_id]
redis_url = instance.tags.to_h['ENV_REDIS_URL']

Sidekiq.configure_server { |config| config.redis = { url: redis_url } }
Sidekiq.configure_client { |config| config.redis = { url: redis_url, size: 1 } }

class HardWorker
  include Sidekiq::Worker
  def perform
    sleep 10
  end
end

# bundle exec sidekiq -r ./app.rb -c 3
