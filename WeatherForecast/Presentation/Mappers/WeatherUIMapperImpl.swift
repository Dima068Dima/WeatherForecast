import UIKit

final class WeatherUIMapperImpl {
    private let dateFormatter: DateFormatter
    private let temperatureFormatter: NumberFormatter
    
    init(
        dateFormatter: DateFormatter = DateFormatter(),
        temperatureFormatter: NumberFormatter = NumberFormatter()
    ) {
        self.dateFormatter = dateFormatter
        self.temperatureFormatter = temperatureFormatter
        setupFormatters()
    }
    
    private func setupFormatters() {
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        temperatureFormatter.numberStyle = .decimal
        temperatureFormatter.maximumFractionDigits = 0
    }
    
    // MARK: - Private mapping methods
    private func mapCurrentWeather(_ current: CurrentWeather) -> CurrentWeatherUI {
        let icon = current.imageData.flatMap { UIImage(data: $0) }
        let details = [
            WeatherDetail(icon: "💨", value: "\(Int(current.windSpeed)) км/ч"),
            WeatherDetail(icon: "💧", value: "\(current.humidity)%"),
            WeatherDetail(icon: "☀️", value: "UV \(Int(current.uvIndex))"),
            WeatherDetail(icon: "🌡️", value: "\(Int(current.feelsLike))°")
        ]
        
        return CurrentWeatherUI(
            temperature: "\(Int(current.temperature))°",
            feelsLike: "\(Int(current.feelsLike))°",
            condition: current.condition,
            icon: icon,
            windSpeed: current.windSpeed,
            humidity: current.humidity,
            uvIndex: current.uvIndex,
            details: details
        )
    }
    
    private func mapHourlyWeather(_ hourly: HourlyWeather) -> HourlyWeatherUI {
        let icon = hourly.imageData.flatMap { UIImage(data: $0) }
        
        return HourlyWeatherUI(
            time: hourly.time,
            temperature: "\(Int(hourly.temperature))°",
            condition: hourly.condition,
            icon: icon
        )
    }
    
    private func mapDailyWeather(_ daily: DailyWeather) -> DailyWeatherUI {
        let icon = daily.imageData.flatMap { UIImage(data: $0) }
        
        return DailyWeatherUI(
            date: daily.date,
            maxTemp: "\(Int(daily.maxTemp))°",
            minTemp: "\(Int(daily.minTemp))°",
            condition: daily.condition,
            icon: icon
        )
    }
}

// MARK: - WeatherUIMapper -
extension WeatherUIMapperImpl: WeatherUIMapper {
    func mapToUI(_ weather: WeatherData) -> WeatherUI {
        let currentUI = mapCurrentWeather(weather.current)
        let hourlyUI = weather.hourly.map(mapHourlyWeather)
        let dailyUI = weather.daily.map(mapDailyWeather)
        
        return WeatherUI(
            cityName: weather.cityName,
            current: currentUI,
            hourly: hourlyUI,
            daily: dailyUI
        )
    }
}
