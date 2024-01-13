class GeolocationFacade
  def initialize(location)
    @location = location
  end

  def geocode
    service = LocationService.new
    json = service.find_lat_and_lon(@location)
    @geocode = Geocode.new(json)
  end
end