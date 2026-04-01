import UIKit
import Combine
import SnapKit

final class WeatherViewController: UIViewController {
    // MARK: - UI components
    private let backgroundView = GradientBackgroundView()
    private let weatherView = WeatherView()
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    // MARK: - Properties
    private let viewModel: WeatherViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupBindings()
        setupActions()
        
        Task {
            await viewModel.loadWeather()
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .clear
        
        addSubviews()
        setupConstraints()
        
        weatherView.backgroundColor = .clear
        loadingView.backgroundColor = .clear
        errorView.backgroundColor = .clear
        
        weatherView.isHidden = true
        loadingView.isHidden = true
        errorView.isHidden = true
    }
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(weatherView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        weatherView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        title = Strings.Navigation.weather
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupBindings() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    private func setupActions() {
        errorView.addRetryTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - State handling
    private func handleState(_ state: ViewState<WeatherUI>) {
        switch state {
            case .loading:
                showLoading()
            case .success(let weather):
                showWeather(weather)
                updateBackground(for: weather.current.conditionType)
            case .error(let message):
                showError(message)
        }
    }
    
    private func showLoading() {
        weatherView.isHidden = true
        errorView.isHidden = true
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    private func showWeather(_ weather: WeatherUI) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
        errorView.isHidden = true
        weatherView.isHidden = false
        weatherView.configure(with: weather)
    }
    
    private func updateBackground(for condition: WeatherCondition) {
        if let gradientBackground = backgroundView as? GradientBackgroundView {
            gradientBackground.updateForWeatherCondition(condition)
        }
    }
    
    private func showError(_ message: String) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
        weatherView.isHidden = true
        errorView.isHidden = false
        errorView.configure(with: message)
    }
    
    // MARK: - Actions
    @objc private func retryButtonTapped() {
        Task {
            await viewModel.retry()
        }
    }
}
