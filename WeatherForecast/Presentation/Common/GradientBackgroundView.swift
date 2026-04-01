import UIKit
import SnapKit

final class GradientBackgroundView: UIView {
    // MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    private var animation: CABasicAnimation?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        startAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Setup
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1).cgColor,
            UIColor(red: 0.3, green: 0.5, blue: 0.9, alpha: 1).cgColor,
            UIColor(red: 0.1, green: 0.3, blue: 0.7, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(gradientLayer)
    }
    
    private func startAnimation() {
        animation = CABasicAnimation(keyPath: "locations")
        animation?.fromValue = [0, 0.5, 1]
        animation?.toValue = [0, 0.8, 1]
        animation?.duration = 3
        animation?.autoreverses = true
        animation?.repeatCount = .infinity
        animation?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        if let animation = animation {
            gradientLayer.add(animation, forKey: "gradientAnimation")
        }
    }
    
    private func getColorsForCondition(_ condition: WeatherCondition) -> [CGColor] {
        switch condition {
            case .sunny, .clear:
                return [
                    UIColor(red: 0.2, green: 0.6, blue: 0.9, alpha: 1).cgColor,
                    UIColor(red: 0.3, green: 0.7, blue: 1.0, alpha: 1).cgColor,
                    UIColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 1).cgColor
                ]
                
            case .partlyCloudy, .cloudy, .overcast:
                return [
                    UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 1).cgColor,
                    UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 1).cgColor,
                    UIColor(red: 0.3, green: 0.4, blue: 0.5, alpha: 1).cgColor
                ]
                
            case .lightRain, .rain, .heavyRain:
                return [
                    UIColor(red: 0.3, green: 0.4, blue: 0.5, alpha: 1).cgColor,
                    UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 1).cgColor,
                    UIColor(red: 0.2, green: 0.3, blue: 0.4, alpha: 1).cgColor
                ]
                
            case .snow:
                return [
                    UIColor(red: 0.6, green: 0.7, blue: 0.8, alpha: 1).cgColor,
                    UIColor(red: 0.7, green: 0.8, blue: 0.9, alpha: 1).cgColor,
                    UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 1).cgColor
                ]
                
            case .thunderstorm:
                return [
                    UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 1).cgColor,
                    UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1).cgColor,
                    UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1).cgColor
                ]
                
            case .mist, .fog:
                return [
                    UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor,
                    UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor,
                    UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1).cgColor
                ]
                
            case .unknown:
                return [
                    UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1).cgColor,
                    UIColor(red: 0.3, green: 0.5, blue: 0.9, alpha: 1).cgColor,
                    UIColor(red: 0.1, green: 0.3, blue: 0.7, alpha: 1).cgColor
                ]
        }
    }
    
    // MARK: - Public Methods
    func updateForWeatherCondition(_ condition: WeatherCondition) {
        let colors = getColorsForCondition(condition)
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = gradientLayer.colors
        colorAnimation.toValue = colors
        colorAnimation.duration = 0.5
        colorAnimation.fillMode = .forwards
        colorAnimation.isRemovedOnCompletion = false
        
        gradientLayer.colors = colors
        gradientLayer.add(colorAnimation, forKey: "colorChange")
    }
}
