import Foundation

struct CurrentWeatherDTO: Codable {
    let location: Location
    let current: Current
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
    }
    
    struct Current: Codable {
        let tempC: Double
        let feelslikeC: Double
        let condition: Condition
        let windKph: Double
        let humidity: Int
        let uv: Double
        
        enum CodingKeys: String, CodingKey {
            case tempC = "temp_c"
            case feelslikeC = "feelslike_c"
            case condition
            case windKph = "wind_kph"
            case humidity
            case uv
        }
    }
    
    struct Condition: Codable {
        let text: String
        let icon: String
    }
}
