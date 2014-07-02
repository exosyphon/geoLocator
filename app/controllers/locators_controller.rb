require 'simple_geolocation'

class LocatorsController < ApplicationController
  def index
    ip = request.remote_ip
    if ip == '127.0.0.1'
      ip = '74.125.113.104'
    end
    @location = SimpleGeolocation::Geocoder.new(ip).geocode!
  end
end
