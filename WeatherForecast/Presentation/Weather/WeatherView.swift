import UIKit
import SnapKit

final class WeatherView: UIView {
    // MARK: - UI components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let currentWeatherCard = CurrentWeatherCardView()
    private let hourlyForecastView = HourlyForecastView()
    private let dailyForecastView = DailyForecastView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubviews()
        setupConstraints()
        setupScrollView()
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [currentWeatherCard, hourlyForecastView, dailyForecastView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Private methods -
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        currentWeatherCard.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        hourlyForecastView.snp.makeConstraints {
            $0.top.equalTo(currentWeatherCard.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }
        
        dailyForecastView.snp.makeConstraints {
            $0.top.equalTo(hourlyForecastView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Public methods -
    func configure(with weather: WeatherUI) {
        currentWeatherCard.configure(with: weather)
        hourlyForecastView.configure(with: weather.hourly)
        dailyForecastView.configure(with: weather.daily)
    }
}
