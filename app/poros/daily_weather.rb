class DailyWeather
  attr_reader :date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon

  def initialize(data)
    # binding.pry
    @date = data[:date]
    @sunrise = data[:astro][:sunrise]
    @sunset = data[:astro][:sunset]
    @max_temp = data[:day][:max_temp_f]
    @min_temp = data[:day][:min_temp_f]
    @visibility = data[:day][:avgvis_miles]
    @condition = data[:day][:condition][:text]
    @icon = data[:day][:condition][:icon]
  end
end