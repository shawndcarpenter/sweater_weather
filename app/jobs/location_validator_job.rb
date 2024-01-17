class LocationValidatorJob < ApplicationJob
  queue_as :default

  def perform(location)
    GeolocationFacade.new(location).geocode.class == Geocode
  end
end
