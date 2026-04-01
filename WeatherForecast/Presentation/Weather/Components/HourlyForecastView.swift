import UIKit
import SnapKit

final class HourlyForecastView: UIView {
    // MARK: - UI components
    private let titleLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
 
    // MARK: - Properties
    private var hourlyData: [HourlyWeatherUI] = []
    
    // MARK: - Initialization
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
        setupCollectionView()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Strings.Titles.hourlyForecast
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
    }
    
    private func setupCollectionView() {
        let layout = makeCollectionViewLayout()
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: Constants.Identifiers.hourlyWeatherCell)
        collectionView.dataSource = self
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 100)
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        return layout
    }
    
    // MARK: - Public methods -
    func configure(with hourly: [HourlyWeatherUI]) {
        self.hourlyData = hourly
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource -
extension HourlyForecastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Identifiers.hourlyWeatherCell,
            for: indexPath
        ) as? HourlyWeatherCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: hourlyData[indexPath.item])
        return cell
    }
}
