import Foundation

final class WeatherRepositoryImpl {
    
    private let apiClient: APIClient
    private let imageCacheService: ImageCacheService
    private let weatherDomainMapper: WeatherDomainMapper
    
    init(apiClient: APIClient,
         imageCacheService: ImageCacheService,
         weatherDomainMapper: WeatherDomainMapper
    ) {
        self.apiClient = apiClient
        self.imageCacheService = imageCacheService
        self.weatherDomainMapper = weatherDomainMapper
    }
        
    // MARK: - Private methods
    private func enrichWithImageData<T: ImageLoadable>(_ items: [T]) async -> [T] {
        var updatedItems = items
        
        await withTaskGroup(of: (Int, Data?).self) { group in
            for (index, item) in items.enumerated() {
                group.addTask {
                    let imageData = await self.loadImageData(from: item.iconURL)
                    return (index, imageData)
                }
            }
            
            for await (index, imageData) in group {
                updatedItems[index].imageData = imageData
            }
        }
        
        return updatedItems
    }
        
    private func loadImageData(from urlString: String) async -> Data? {
        if let cachedData = imageCacheService.getData(forKey: urlString) {
            return cachedData
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            imageCacheService.setData(data, forKey: urlString)
            return data
        } catch {
            print("Failed to load image from \(urlString): \(error)")
            return nil
        }
    }
}

extension WeatherRepositoryImpl: WeatherRepository {
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherData {
        async let currentTask = apiClient.fetchCurrentWeather(lat: lat, lon: lon)
        async let forecastTask = apiClient.fetchForecast(lat: lat, lon: lon, days: 3)
        
        let (currentResponse, forecastResponse) = try await (currentTask, forecastTask)
       
        var weatherData = weatherDomainMapper.mapToDomain(
            current: currentResponse,
            forecast: forecastResponse
        )
      
        weatherData.hourly = await enrichWithImageData(weatherData.hourly)
        weatherData.daily = await enrichWithImageData(weatherData.daily)
    
        return weatherData
    }
}
