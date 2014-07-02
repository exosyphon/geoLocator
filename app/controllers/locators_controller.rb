require 'simple_geolocation'

class LocatorsController < ApplicationController
  def index
    ip = request.remote_ip.present? || '50.155.177.142'
    @location = SimpleGeolocation::Geocoder.new(ip).geocode!
  end
end
