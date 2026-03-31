import Foundation

struct HourlyWeather: Equatable, ImageLoadable {
    let time: String
    let temperature: Double
    let condition: String
    let iconURL: String
    var imageData: Data?
}
