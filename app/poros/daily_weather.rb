class DailyWeather
  attr_reader :date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon, :visibility

  def initialize(data)
    @date = data[:date]
    @sunrise = data[:astro][:sunrise]
    @sunset = data[:astro][:sunset]
    @max_temp = data[:day][:maxtemp_f]
    @min_temp = data[:day][:mintemp_f]
    @visibility = data[:day][:avgvis_miles]
    @condition = data[:day][:condition][:text]
    @icon = data[:day][:condition][:icon]
  end
end