require 'simple_geolocation'

class LocatorsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :new_request

  def index
    puts request.env
    @one = " stuff #{request.env['REMOTE_ADDR']}"
    @two = " stuff #{request.env['HTTP_X_FORWARDED_FOR']}"
    @three =  " stuff #{request.env['HTTP_CLIENT_IP']}"
    @four = "sadf #{request.env['REMOTE_HOST']}"
    @five =  " stuff #{request.env['action_dispatch.remote_ip']}"
    ip = request.remote_ip
    if ip == '127.0.0.1'
      ip = '74.125.113.104'
    end
    @location = get_my_location(ip)
  end

  def new_request
    ip = params[:ip_input]

    if ip.blank? || ip !~ /\d+\.\d+\.\d+\.\d+/
      ip = '74.125.113.104'
    end

    @location = get_my_location(ip)

    render :index
  end

  private

  def get_my_location(ip)
    SimpleGeolocation::Geocoder.new(ip).geocode!
  end
end
