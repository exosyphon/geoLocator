require 'simple_geolocation'

class LocatorsController < ApplicationController
  def index
    puts request.remote_ip
    ip = '50.155.177.142'
    @location = SimpleGeolocation::Geocoder.new(ip).geocode!
  end
end
