import Foundation

protocol WeatherUIMapper {
    func mapToUI(_ weather: WeatherData) -> WeatherUI
}
