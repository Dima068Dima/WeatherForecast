import Foundation

struct ForecastResponseDTO: Codable {
    let location: LocationDTO
    let current: CurrentDTO
    let forecast: ForecastDTO
    
    struct LocationDTO: Codable {
        let name: String
        let region: String
        let country: String
    }
    
    struct CurrentDTO: Codable {
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
    
    struct ForecastDTO: Codable {
        let forecastday: [ForecastDay]
    }
    
    struct ForecastDay: Codable {
        let date: String
        let day: Day
        let hour: [Hour]
    }
    
    struct Day: Codable {
        let maxtempC: Double
        let mintempC: Double
        let condition: Condition
        
        enum CodingKeys: String, CodingKey {
            case maxtempC = "maxtemp_c"
            case mintempC = "mintemp_c"
            case condition
        }
    }
    
    struct Hour: Codable {
        let time: String
        let tempC: Double
        let condition: Condition
        
        enum CodingKeys: String, CodingKey {
            case time
            case tempC = "temp_c"
            case condition
        }
    }
}
