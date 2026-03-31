import Foundation

protocol WeatherRepository {
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherData
}
