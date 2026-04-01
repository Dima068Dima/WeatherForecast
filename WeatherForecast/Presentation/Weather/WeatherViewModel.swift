import Combine
import Foundation

final class WeatherViewModel {
    // MARK: - Properties
    @Published private(set) var state: ViewState<WeatherUI> = .loading
    private let getWeatherUseCase: GetWeatherWithLocationUseCase
    private let weatherUIMapper: WeatherUIMapper
    
    // MARK: - Initialization
    init(
        getWeatherUseCase: GetWeatherWithLocationUseCase,
        weatherUIMapper: WeatherUIMapper
    ) {
        self.getWeatherUseCase = getWeatherUseCase
        self.weatherUIMapper = weatherUIMapper
    }
    
    // MARK: - Public methods
    @MainActor
    func loadWeather() async {
        state = .loading
        
        do {
            let weather = try await getWeatherUseCase.execute()
            let weatherUI = weatherUIMapper.mapToUI(weather)
            state = .success(weatherUI)
        } catch let error as APIError {
            state = .error(error.localizedDescription)
        } catch {
            state = .error(Strings.Errors.unknown)
        }
    }
    
    @MainActor
    func retry() async {
        await loadWeather()
    }
}
