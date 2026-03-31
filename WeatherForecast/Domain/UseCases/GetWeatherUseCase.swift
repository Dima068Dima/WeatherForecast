import Foundation

protocol GetWeatherUseCase {
    func execute(lat: Double, lon: Double) async throws -> WeatherData
}
