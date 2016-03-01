require 'twilio-ruby'
require 'pry'
require 'pp'

Twilio.configure do |config|
  config.account_sid = ENV["TWILIO_ACCOUNT_SID"]
  config.auth_token = ENV["TWILIO_AUTH_TOKEN"]
end

@client = Twilio::REST::Client.new

begin
  message = @client.messages.create({
    from: ENV["TWILIO_PHONE_NUMBER"], # expects phone number formatted like '+14159341234'
    to: ENV["RECIPIENT_PHONE_NUMBER"], # expects phone number formatted like '+14159341234'
    body: 'Hello world!'
  }) #> Twilio::REST::Message

  attributes = {
    :api_version => message.api_version,
    :messaging_service_sid => message.messaging_service_sid,
    :direction => message.direction, # "outbound-api"
    :account_sid => message.account_sid,

    :sid => message.sid,
    :status => message.status, # "queued"
    :to => message.to, # "+11234567890"
    :from => message.from, # "+10987654321"
    :body => message.body, # "Hello world!"
    :num_segments => message.num_segments, # "1"
    :num_media => message.num_media, # "0"
    :date_created => message.date_created, # "Sun, 28 Feb 2016 23:28:34 +0000"
    :date_updated => message.date_updated, # "Sun, 28 Feb 2016 23:28:34 +0000"
    :date_sent => message.date_sent, # "Sun, 28 Feb 2016 23:28:34 +0000"

    :price => message.price,
    :price_unit => message.price_unit,
    :error_code => message.error_code,
    :error_message => message.error_message,
    :uri => message.uri, # "/2010-04-01/Accounts/:sid/Messages/:sid.json"
    :subresource_uris => message.subresource_uris, #> {"media"=> "/2010-04-01/Accounts/:sid/Messages/:sid/Media.json"}
    #:media => message.media,
    #:media_path => message.media.instance_variable_get('@path')
  }

  puts "SENT AN SMS"
  pp attributes
rescue => e
  puts "#{e.class} -- #{e.message}"
end
