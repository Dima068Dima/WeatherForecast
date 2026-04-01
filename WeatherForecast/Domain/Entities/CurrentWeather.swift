import Foundation

struct CurrentWeather: Equatable {
    let temperature: Double
    let feelsLike: Double
    let condition: String
    let conditionType: WeatherCondition
    let iconURL: String
    var imageData: Data?
    let windSpeed: Double
    let humidity: Int
    let uvIndex: Double
}
