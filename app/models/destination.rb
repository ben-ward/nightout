require 'net/http'
require 'uri'
require 'json'

class Destination < ActiveRecord::Base
  has_many :votes
  belongs_to :event

  def price_estimate
    uri = URI.parse('https://sandbox-api.uber.com/v1/estimates/price')
    parameters = {
      :server_token => ENV['UBER_SERVER_TOKEN'],
      :start_latitude => 20.7484586,
      :start_longitude => -156.4380881,
      :end_latitude => latitude,
      :end_longitude => longitude
    }
    uri.query = URI.encode_www_form( parameters )
    response = Net::HTTP.get( uri )
    JSON.parse(response)
  end

end
