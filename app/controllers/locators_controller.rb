require 'simple_geolocation'

class LocatorsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :new_request

  def index
    x_forwarded_ip = request.env['HTTP_X_FORWARDED_FOR']
    ip = request.remote_ip

    if ip == '127.0.0.1'
      ip = '74.125.113.104'
    end

    if x_forwarded_ip.present?
      @location = get_my_location(x_forwarded_ip.split(',')[0])
      if @location.nil?
        @location = get_my_location(ip)
      end
    else
      @location = get_my_location(ip)
    end
  end

  def new_request
    ip = params[:ip_input]

    if ip.blank? || ip !~ /\d+\.\d+\.\d+\.\d+/ || ip == '127.0.0.1'
      ip = '74.125.113.104'
    end

    @location = get_my_location(ip)

    if @location.nil?
      render 404
    else
      render :index
    end
  end

  private

  def get_my_location(ip)
    SimpleGeolocation::Geocoder.new(ip).geocode!
  end
end
