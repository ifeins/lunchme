CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ID'],
    aws_secret_access_key: ENV['AWS_ACCESS_KEY'],
    region: 'eu-west-1',
    endpoint: "https://s3.amazonaws.com/#{ENV['AWS_BUCKET_NAME']}/"
  }
  config.fog_directory = ENV['AWS_BUCKET_NAME']
  config.fog_public = false
end