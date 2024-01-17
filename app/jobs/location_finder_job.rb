class LocationFinderJob < ApplicationJob
  queue_as :default

  def perform(location)
    GeolocationFacade.new(location).geocode
  end
end
