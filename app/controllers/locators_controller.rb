require 'simple_geolocation'

class LocatorsController < ApplicationController
  def index
    ip = request.remote_ip
    if ip == '127.0.0.1'
      ip = '50.155.177.142'
    end
    @location = SimpleGeolocation::Geocoder.new(ip).geocode!
  end
end
