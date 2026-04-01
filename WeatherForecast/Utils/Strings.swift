import Foundation

enum Strings {
    // MARK: - Navigation -
    enum Navigation {
        static let weather = "Погода"
    }
    
    // MARK: - Titles -
    enum Titles {
        static let hourlyForecast = "Почасовой прогноз"
        static let dailyForecast = "Прогноз на 3 дня"
        static let loading = "Загрузка..."
    }
    
    // MARK: - Buttons -
    enum Buttons {
        static let retry = "Повторить"
    }
    
    // MARK: - Errors -
    enum Errors {
        static let invalidURL = "Неверный адрес запроса"
        static let unknown = "Произошла неизвестная ошибка"
        static let network = "Ошибка сети:"
        static let noData = "Нет данных от сервера"
        static let decodingError = "Ошибка обработки данных"
        static let invalidResponse = "Неверный ответ сервера"
        static let unauthorized = "Ошибка авторизации"
        static let notFound = "Ресурс не найден"
    }
    
    // MARK: - Weather details -
    enum WeatherDetails {
        static let windSpeed = "км/ч"
        static let humidity = "%"
        static let uv = "UV"
        static let feelsLike = "°"
        static let temperature = "°"
    }
}
