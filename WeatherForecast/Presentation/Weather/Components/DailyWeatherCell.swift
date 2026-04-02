import UIKit
import SnapKit

final class DailyWeatherCell: UITableViewCell {    
    // MARK: - UI components
    private let dateLabel = UILabel()
    private let iconImageView = UIImageView()
    private let conditionLabel = UILabel()
    private let tempLabel = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods -
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        addSubviews()
        setupConstraints()
        setupDateLabel()
        setupIconImageView()
        setupConditionLabel()
        setupTempLabel()
    }
    
    private func addSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(tempLabel)
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
    }
    
    private func setupDateLabel() {
        dateLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateLabel.textColor = .white
    }
    
    private func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
    }
    
    private func setupConditionLabel() {
        conditionLabel.font = .systemFont(ofSize: 14)
        conditionLabel.textColor = .white
    }
    
    private func setupTempLabel() {
        tempLabel.font = .systemFont(ofSize: 16, weight: .medium)
        tempLabel.textAlignment = .right
        tempLabel.textColor = .white
    }
    
    // MARK: - Public methods -
    func configure(with weather: DailyWeatherUI) {
        dateLabel.text = weather.date
        conditionLabel.text = weather.condition
        tempLabel.text = "\(weather.minTemp) / \(weather.maxTemp)"
        iconImageView.image = weather.icon
    }
}
