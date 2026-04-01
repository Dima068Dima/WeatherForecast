import UIKit
import SnapKit

final class DailyForecastView: UIView {
    private let titleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var dailyData: [DailyWeatherUI] = []
    private var tableViewHeightConstraint: Constraint?
    
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
        setupTitleLabel()
        setupTableView()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview()
            tableViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Strings.Titles.dailyForecast
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: Constants.Identifiers.dailyWeatherCell)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Public methods -
    func configure(with daily: [DailyWeatherUI]) {
        self.dailyData = daily
        tableView.reloadData()
        
        let height = CGFloat(daily.count * 70)
        tableViewHeightConstraint?.update(offset: height)
    }
}

// MARK: - PUITableViewDelegate -
extension DailyForecastView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.dailyWeatherCell,
            for: indexPath
        ) as? DailyWeatherCell else {
            return UITableViewCell()
        }
        cell.configure(with: dailyData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
