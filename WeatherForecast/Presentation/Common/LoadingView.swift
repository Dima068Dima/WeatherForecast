import UIKit
import SnapKit

final class LoadingView: UIView {
    // MARK: - UI components
    private let activityIndicator = UIActivityIndicatorView()
    private let titleLabel = UILabel()
    
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
        setupActivityIndicator()
        setupTitleLabel()
    }
    
    private func addSubviews() {
        addSubview(activityIndicator)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(activityIndicator.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .systemBlue
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Strings.Titles.loading
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Public methods -
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
