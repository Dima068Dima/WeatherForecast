import Foundation

struct DailyWeather: Equatable, ImageLoadable {
    let date: String
    let maxTemp: Double
    let minTemp: Double
    let condition: String
    let iconURL: String
    var imageData: Data?
}
