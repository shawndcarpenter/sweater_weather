require "connectable.rb"

class LocationService
  include Connectable

  def conn
    Faraday.new(url: "https://www.mapquestapi.com/") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.map_quest[:key]
    end
  end

  def find_lat_and_lon(location)
    get_url("geocoding/v1/address?location=#{location}") 
  end

  def find_route(origin, destination)
    get_url("directions/v2/route?from=#{origin}&to=#{destination}")
  end
end