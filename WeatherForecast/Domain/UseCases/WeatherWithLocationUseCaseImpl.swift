import Foundation

final class WeatherWithLocationUseCaseImpl {
    
    private let locationUseCase: GetLocationUseCase
    private let weatherUseCase: GetWeatherUseCase
    
    init(
        locationUseCase: GetLocationUseCase,
        weatherUseCase: GetWeatherUseCase
    ) {
        self.locationUseCase = locationUseCase
        self.weatherUseCase = weatherUseCase
    }
}

// MARK: - GetWeatherWithLocationUseCase -
extension WeatherWithLocationUseCaseImpl: GetWeatherWithLocationUseCase {
    func execute() async throws -> WeatherData {
        let location = try await locationUseCase.execute()
        let weather = try await weatherUseCase.execute(lat: location.lat, lon: location.lon)
        return weather
    }
}
