import Foundation

final class WeatherDomainMapperImpl {
    // MARK: - Private mapping methods
    private func mapCurrentWeather(
        _ current: CurrentWeatherDTO.Current,
        location: CurrentWeatherDTO.Location
    ) -> CurrentWeather {
        return CurrentWeather(
            temperature: current.tempC,
            feelsLike: current.feelslikeC,
            condition: current.condition.text,
            conditionType: WeatherCondition(from: current.condition.text),
            iconURL: "https:\(current.condition.icon)",
            imageData: nil,
            windSpeed: current.windKph,
            humidity: current.humidity,
            uvIndex: current.uv
        )
    }
    
    private func mapHourlyWeather(from forecast: ForecastResponseDTO) -> [HourlyWeather] {
        var hourlyWeather: [HourlyWeather] = []
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: Date())
        
        guard let todayForecast = forecast.forecast.forecastday.first else {
            return []
        }
        
        for hour in todayForecast.hour {
            let hourComponent = calendar.component(.hour, from: parseDate(hour.time))
            if hourComponent >= currentHour {
                hourlyWeather.append(HourlyWeather(
                    time: formatHour(from: hour.time),
                    temperature: hour.tempC,
                    condition: hour.condition.text,
                    iconURL: "https:\(hour.condition.icon)",
                    imageData: nil
                ))
            }
        }
        
        if forecast.forecast.forecastday.count > 1 {
            let nextDay = forecast.forecast.forecastday[1]
            for hour in nextDay.hour {
                hourlyWeather.append(HourlyWeather(
                    time: formatHour(from: hour.time),
                    temperature: hour.tempC,
                    condition: hour.condition.text,
                    iconURL: "https:\(hour.condition.icon)",
                    imageData: nil
                ))
            }
        }
        
        return hourlyWeather
    }
    
    private func mapDailyWeather(from forecast: ForecastResponseDTO) -> [DailyWeather] {
        return forecast.forecast.forecastday.map { day in
            DailyWeather(
                date: formatDate(from: day.date),
                maxTemp: day.day.maxtempC,
                minTemp: day.day.mintempC,
                condition: day.day.condition.text,
                iconURL: "https:\(day.day.condition.icon)",
                imageData: nil
            )
        }
    }
    
    private func parseDate(_ dateString: String) -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        let simpleFormatter = DateFormatter()
        simpleFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return simpleFormatter.date(from: dateString) ?? Date()
    }
    
    private func formatHour(from dateString: String) -> String {
        let date = parseDate(dateString)
        return DateFormatter.hourFormatter.string(from: date)
    }
    
    private func formatDate(from dateString: String) -> String {
        if let date = DateFormatter.dateFormatter.date(from: dateString) {
            return DateFormatter.dayFormatter.string(from: date).capitalized
        }
        return dateString
    }
}

// MARK: - WeatherDomainMapper
extension WeatherDomainMapperImpl: WeatherDomainMapper {
    func mapToDomain(
        current: CurrentWeatherDTO,
        forecast: ForecastResponseDTO
    ) -> WeatherData {
        let currentWeather = mapCurrentWeather(current.current, location: current.location)
        let hourlyWeather = mapHourlyWeather(from: forecast)
        let dailyWeather = mapDailyWeather(from: forecast)
        
        return WeatherData(
            cityName: current.location.name,
            current: currentWeather,
            hourly: hourlyWeather,
            daily: dailyWeather
        )
    }
}
