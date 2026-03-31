import Foundation

protocol WeatherDomainMapper {
    func mapToDomain(
          current: CurrentWeatherDTO,
          forecast: ForecastResponseDTO
      ) -> WeatherData
}
