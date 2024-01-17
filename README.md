# README

XXX ADD ERROR HANDLING FOR NO RESULTS FOUND FOR SERVICES

# Sweater Weather
> This application handles requests for getting weather for a location, creating users, logging in users and creating roadtrips.

## Installation

OS X & Linux:
This project runs on Rails 7.0.8.

Fork and clone [this repository](https://github.com/shawndcarpenter/sweater_weather).

Windows:

This product is not compatible with Windows.

## API
#### MapQuest
> This application uses the MapQuest API for Routing and Geolocation found [here](https://developer.mapquest.com/).

#### Weather API
> This application uses the Weather API to find current weather and daily/hourly forecasts found [here](https://www.weatherapi.com/).

### To add your own MapQuest and Weather API keys
1. Delete config/master.key and config/credentials.yml.enc.

2. Enter the following in your terminal:

```sh
EDITOR="code --wait" rails credentials:edit
```

3. In the window that has opened, titled credentials.yml.enc, add the following. Make sure that key is on a new line with a tab before it.

```sh
map_quest:
  key: the_api_key_given_to_you

weather_api:
  key: the_api_key_given_to_you
```

4. Close this file to save your credentials.

### Generating API Keys Within This Application
This application uses the built-in SecureRandom.hex method to generate API Keys once a user has been created. They are stored in the database and show up as `FILTERED` in the Rails console.

### Gems
The [Shoulda Matchers Gem](https://github.com/thoughtbot/shoulda-matchers) is used for one-liner testing of models.

The [SimpleCov Gem](https://github.com/simplecov-ruby/simplecov) provides test coverage analysis for our application.

This application simulates API calls to MapQuest and WeatherAPI using the [WebMock gem](https://github.com/bblimke/webmock) and the [VCR gem](https://github.com/vcr/vcr).

This application uses the [Pry gem](https://github.com/pry/pry) and [RSpec Rails](https://github.com/rspec/rspec-rails) within the testing environment for unit and feature testing.
