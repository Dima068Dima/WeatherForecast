import Foundation
import Alamofire

final class APIClientImpl {
    private let networkManager: NetworkManager
    private let apiKey: String
    
    init(
        networkManager: NetworkManager,
        apiKey: String = Constants.API.apiKey
    ) {
        self.networkManager = networkManager
        self.apiKey = apiKey
    }
}

// MARK: - APIClient -
extension APIClientImpl: APIClient {
    func fetchCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherDTO {
        let parameters: [String: Any] = [
            "key": apiKey,
            "q": "\(lat),\(lon)"
        ]
        
        return try await networkManager.request(
            endpoint: "/current.json",
            method: .get,
            parameters: parameters
        )
    }
    
    func fetchForecast(lat: Double, lon: Double, days: Int = 3) async throws -> ForecastResponseDTO {
        let parameters: [String: Any] = [
            "key": apiKey,
            "q": "\(lat),\(lon)",
            "days": days
        ]
        
        return try await networkManager.request(
            endpoint: "/forecast.json",
            method: .get,
            parameters: parameters
        )
    }
}
