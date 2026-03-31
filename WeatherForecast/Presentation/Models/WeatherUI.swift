import UIKit

struct WeatherUI: Equatable {
    let cityName: String
    let current: CurrentWeatherUI
    let hourly: [HourlyWeatherUI]
    let daily: [DailyWeatherUI]
}

struct CurrentWeatherUI: Equatable {
    let temperature: String
    let feelsLike: String
    let condition: String
    let icon: UIImage?
    let windSpeed: Double
    let humidity: Int
    let uvIndex: Double
    let details: [WeatherDetail]
}

struct WeatherDetail: Equatable {
    let icon: String
    let value: String
}

struct HourlyWeatherUI: Equatable {
    let time: String
    let temperature: String
    let condition: String
    let icon: UIImage?
}

struct DailyWeatherUI: Equatable {
    let date: String
    let maxTemp: String
    let minTemp: String
    let condition: String
    let icon: UIImage?
}
