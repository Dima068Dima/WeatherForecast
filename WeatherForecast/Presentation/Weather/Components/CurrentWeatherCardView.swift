import UIKit
import SnapKit

final class CurrentWeatherCardView: UIView {
    // MARK: - UI components
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let conditionLabel = UILabel()
    private let detailsStackView = UIStackView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods -
    private func setupUI() {
        backgroundColor = .clear
        
        addSubviews()
        setupConstraints()
        setupSelf()
        setupCityLabel()
        setupTemperatureLabel()
        setupConditionLabel()
        setupDetailsStackView()
    }
    
    private func addSubviews() {
        addSubview(cityLabel)
        addSubview(temperatureLabel)
        addSubview(conditionLabel)
        addSubview(detailsStackView)
    }
    
    private func setupConstraints() {
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        conditionLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        detailsStackView.snp.makeConstraints {
            $0.top.equalTo(conditionLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupSelf() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 12
    }
    
    private func setupCityLabel() {
        cityLabel.font = .systemFont(ofSize: 32, weight: .medium)
        cityLabel.textAlignment = .center
        cityLabel.textColor = .white
        cityLabel.numberOfLines = 0
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.font = .systemFont(ofSize: 72, weight: .thin)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
    }
    
    private func setupConditionLabel() {
        conditionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        conditionLabel.textColor = .white.withAlphaComponent(0.8)
        conditionLabel.textColor = .white
        conditionLabel.textAlignment = .center
    }
    
    private func setupDetailsStackView() {
        detailsStackView.axis = .horizontal
        detailsStackView.distribution = .equalSpacing
        detailsStackView.spacing = 16
    }
    
    private func createDetailView(icon: String, value: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        
        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = .systemFont(ofSize: 24)
        iconLabel.textColor = .white.withAlphaComponent(0.8)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 13)
        valueLabel.textColor = .secondaryLabel
        valueLabel.textColor = .white.withAlphaComponent(0.8)
        
        stack.addArrangedSubview(iconLabel)
        stack.addArrangedSubview(valueLabel)
        
        return stack
    }
    
    // MARK: - Public methods -
    func configure(with weather: WeatherUI) {
        cityLabel.text = weather.cityName
        temperatureLabel.text = weather.current.temperature
        conditionLabel.text = weather.current.condition
        
        detailsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
     
        for detail in weather.current.details {
            let detailView = createDetailView(icon: detail.icon, value: detail.value)
            detailsStackView.addArrangedSubview(detailView)
        }
    }
}
