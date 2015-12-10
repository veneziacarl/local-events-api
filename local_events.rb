# require 'httparty'
#
# response = HTTParty.get('http://api.seatgeek.com/2/events?venue.state=MA&venue.city=Boston&datetime_local.gte=2015-12-10&datetime_local.lt=2015-12-11')
# puts response.body, response.code, response.message, response.headers.inspect

require 'net/http'
require 'pry'
require 'json'

argv_string = []
ARGF.argv.each do |arg|
  argv_string << arg
end

uri_string ="http://api.seatgeek.com/2/events?#{argv_string.join("&")}"
uri = URI(uri_string)
response = Net::HTTP.get(uri)

parsed = JSON.parse(response)

output = []
parsed['events'].each do |event|
  output << "#{event["title"]} @ #{event['venue']['name']}"
end

puts output.join("\n")
