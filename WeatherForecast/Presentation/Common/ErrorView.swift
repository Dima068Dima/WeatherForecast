import UIKit
import SnapKit

final class ErrorView: UIView {
    // MARK: - UI components
    private let stackView = UIStackView()
    private let errorImageView = UIImageView()
    private let errorLabel = UILabel()
    private let retryButton = UIButton(type: .system)

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
        backgroundColor = .systemBackground
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(errorImageView)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(retryButton)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(32)
            $0.trailing.lessThanOrEqualToSuperview().offset(-32)
        }
        
        errorImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
        }
        
        retryButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(44)
        }
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
    }
    
    private func setupErrorImageView() {
        errorImageView.image = UIImage(systemName: "exclamationmark.triangle")
        errorImageView.tintColor = .systemOrange
        errorImageView.contentMode = .scaleAspectFit
    }
    
    private func setupErrorLabel() {
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.font = .systemFont(ofSize: 16)
        errorLabel.textColor = .secondaryLabel
    }
    
    private func setupRetryButton() {
        retryButton.setTitle(Strings.Buttons.retry, for: .normal)
        retryButton.backgroundColor = .systemBlue
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.layer.cornerRadius = 12
        retryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    // MARK: - Public methods -
    func configure(with error: String) {
        errorLabel.text = error
    }
    
    func addRetryTarget(_ target: Any?, action: Selector, for event: UIControl.Event) {
        retryButton.addTarget(target, action: action, for: event)
    }
}
