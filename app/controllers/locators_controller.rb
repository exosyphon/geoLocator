require 'simple_geolocation'

class LocatorsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :new_request

  def index
    ip = request.remote_ip
    if ip == '127.0.0.1'
      ip = '74.125.113.104'
    end
    @location = SimpleGeolocation::Geocoder.new(ip).geocode!
  end

  def new_request
    ip = params[:ip_input]

    if ip.blank? || ip !~ /\d+\.\d+\.\d+\.\d+/
      ip = '74.125.113.104'
    end

    @location = SimpleGeolocation::Geocoder.new(ip).geocode!

    render :index
  end
end
