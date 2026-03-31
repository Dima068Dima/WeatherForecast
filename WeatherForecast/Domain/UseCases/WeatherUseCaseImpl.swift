import Foundation

final class WeatherUseCaseImpl {
    
    private let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
}

// MARK: - GetWeatherUseCase -
extension WeatherUseCaseImpl: GetWeatherUseCase {
    func execute(lat: Double, lon: Double) async throws -> WeatherData {
        return try await weatherRepository.fetchWeather(lat: lat, lon: lon)
    }
}
