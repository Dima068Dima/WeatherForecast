import Foundation
import UIKit

enum Constants {
    static let defaultLatitude: Double = 55.7558
    static let defaultLongitude: Double = 37.6173
    static let defaultCity: String = "Москва"
    
    // MARK: - API -
    enum API {
        static let baseURL = "http://api.weatherapi.com/v1"
        static let apiKey = "fa8b3df74d4042b9aa7135114252304"
        static let timeoutInterval: TimeInterval = 30
    }

    // MARK: - Identifiers -
    enum Identifiers {
        static let hourlyWeatherCell = "HourlyWeatherCell"
        static let dailyWeatherCell = "DailyWeatherCell"
    }
}
