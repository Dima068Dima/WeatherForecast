import Foundation

protocol GetWeatherWithLocationUseCase {
    func execute() async throws -> WeatherData
}
