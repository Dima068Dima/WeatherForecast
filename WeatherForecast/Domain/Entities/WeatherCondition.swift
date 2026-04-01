import Foundation

enum WeatherCondition: String {
    case sunny = "sunny"
    case clear = "clear"
    case partlyCloudy = "partly cloudy"
    case cloudy = "cloudy"
    case overcast = "overcast"
    case lightRain = "light rain"
    case rain = "rain"
    case heavyRain = "heavy rain"
    case snow = "snow"
    case thunderstorm = "thunderstorm"
    case mist = "mist"
    case fog = "fog"
    case unknown = "unknown"
    
    init(from string: String) {
        let lowercased = string.lowercased()
        
        switch lowercased {
        case let str where str.contains("sunny") || str.contains("clear"):
            self = .sunny
        case let str where str.contains("partly cloudy"):
            self = .partlyCloudy
        case let str where str.contains("cloudy") || str.contains("overcast"):
            self = .cloudy
        case let str where str.contains("heavy rain") || str.contains("torrential rain"):
            self = .heavyRain
        case let str where str.contains("light rain") || str.contains("patchy rain"):
            self = .lightRain
        case let str where str.contains("rain"):
            self = .rain
        case let str where str.contains("snow"):
            self = .snow
        case let str where str.contains("thunder"):
            self = .thunderstorm
        case let str where str.contains("mist"):
            self = .mist
        case let str where str.contains("fog"):
            self = .fog
        default:
            self = .unknown
        }
    }
}
