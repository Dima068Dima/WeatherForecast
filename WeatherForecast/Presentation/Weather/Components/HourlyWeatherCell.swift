import UIKit
import SnapKit

final class HourlyWeatherCell: UICollectionViewCell {
    // MARK: - UI components
    private let timeLabel = UILabel()
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
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
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = Constants.UI.cornerRadius
       
        addSubviews()
        setupConstraints()
        setupTimeLabel()
        setupIconImageView()
        setupTemperatureLabel()
    }
    
    private func addSubviews() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(temperatureLabel)
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupTimeLabel() {
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textAlignment = .center
        timeLabel.textColor = .secondaryLabel
    }
    
    private func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.font = .systemFont(ofSize: 16, weight: .medium)
        temperatureLabel.textAlignment = .center
    }
    
    // MARK: - Public methods -
    func configure(with weather: HourlyWeatherUI) {
        timeLabel.text = weather.time
        temperatureLabel.text = weather.temperature
        iconImageView.image = weather.icon
    }
}
