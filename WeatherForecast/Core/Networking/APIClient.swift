import Foundation

protocol APIClient {
    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherDTO
    func fetchForecast(lat: Double, lon: Double, days: Int) async throws -> ForecastResponseDTO
}
