import Foundation

struct WeatherData: Equatable {
    let cityName: String
    let current: CurrentWeather
    var hourly: [HourlyWeather]
    var daily: [DailyWeather]
}
