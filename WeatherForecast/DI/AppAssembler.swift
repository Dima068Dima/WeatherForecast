import Foundation

 final class AppAssembler {
     static func makeWeatherViewModel() -> WeatherViewModel {
         let weatherRepository = makeWeatherRepository()
         let locationService = LocationServiceImpl()
         let locationUseCase = LocationUseCaseImpl(locationService: locationService)
         let getWeatherUseCase = WeatherUseCaseImpl(weatherRepository: weatherRepository)
         let getWeatherWithLocationUseCase = WeatherWithLocationUseCaseImpl(
            locationUseCase: locationUseCase,
            weatherUseCase: getWeatherUseCase
         )
         let weatherUIMapper = WeatherUIMapperImpl()
         let weatherViewModel = WeatherViewModel(
            getWeatherUseCase: getWeatherWithLocationUseCase,
            weatherUIMapper: weatherUIMapper
         )
         return weatherViewModel
     }
     
     private static func makeWeatherRepository() -> WeatherRepositoryImpl {
         let apiClient = makeAPIClient()
         let imageCacheService = ImageCacheServiceImpl()
         let weatherDomainMapper = WeatherDomainMapperImpl()
         return WeatherRepositoryImpl(
            apiClient: apiClient,
            imageCacheService: imageCacheService,
            weatherDomainMapper: weatherDomainMapper
         )
     }
     
     private static func makeAPIClient() -> APIClient {
         return APIClientImpl(
            networkManager: makeNetworkManager(),
            apiKey: Constants.API.apiKey
         )
     }
     
     private static func makeNetworkManager() -> NetworkManager {
         return NetworkManagerImpl()
     }
}
