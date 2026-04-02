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
            case .sunny, .clear, .fair, .mostlyClear, .mostlySunny:
                return [
                    UIColor(red: 0.2, green: 0.6, blue: 0.9, alpha: 1).cgColor,
                    UIColor(red: 0.3, green: 0.7, blue: 1.0, alpha: 1).cgColor,
                    UIColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 1).cgColor
                ]
                
            case .partlyCloudy, .cloudy, .mostlyCloudy, .overcast:
                return [
                    UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 1).cgColor,
                    UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 1).cgColor,
                    UIColor(red: 0.3, green: 0.4, blue: 0.5, alpha: 1).cgColor
                ]
                
            case .drizzle, .lightDrizzle, .freezingDrizzle:
                return [
                    UIColor(red: 0.35, green: 0.45, blue: 0.55, alpha: 1).cgColor,
                    UIColor(red: 0.45, green: 0.55, blue: 0.65, alpha: 1).cgColor,
                    UIColor(red: 0.25, green: 0.35, blue: 0.45, alpha: 1).cgColor
                ]
                
            case .lightRain, .patchyRain, .moderateRain, .rain, .heavyRain, .freezingRain:
                return [
                    UIColor(red: 0.3, green: 0.4, blue: 0.5, alpha: 1).cgColor,
                    UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 1).cgColor,
                    UIColor(red: 0.2, green: 0.3, blue: 0.4, alpha: 1).cgColor
                ]
                
            case .showers, .lightShowers, .heavyShowers, .thunderyShowers, .amShowers, .pmShowers:
                return [
                    UIColor(red: 0.28, green: 0.38, blue: 0.48, alpha: 1).cgColor,
                    UIColor(red: 0.38, green: 0.48, blue: 0.58, alpha: 1).cgColor,
                    UIColor(red: 0.18, green: 0.28, blue: 0.38, alpha: 1).cgColor
                ]
                
            case .amLightRain, .pmLightRain, .rainSnowShowers:
                return [
                    UIColor(red: 0.32, green: 0.42, blue: 0.52, alpha: 1).cgColor,
                    UIColor(red: 0.42, green: 0.52, blue: 0.62, alpha: 1).cgColor,
                    UIColor(red: 0.22, green: 0.32, blue: 0.42, alpha: 1).cgColor
                ]
                
            case .thundershowers, .thunderstorm, .thunderstormWithRain, .severeThunderstorms, .isolatedThunderstorms, .scatteredThunderstorms:
                return [
                    UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 1).cgColor,
                    UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1).cgColor,
                    UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1).cgColor
                ]
                
            case .snow, .lightSnow, .moderateSnow, .heavySnow, .snowShowers, .lightSnowShowers, .heavySnowShowers, .snowFlurries:
                return [
                    UIColor(red: 0.6, green: 0.7, blue: 0.8, alpha: 1).cgColor,
                    UIColor(red: 0.7, green: 0.8, blue: 0.9, alpha: 1).cgColor,
                    UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 1).cgColor
                ]
                
            case .blizzard, .blowingSnow:
                return [
                    UIColor(red: 0.55, green: 0.65, blue: 0.75, alpha: 1).cgColor,
                    UIColor(red: 0.65, green: 0.75, blue: 0.85, alpha: 1).cgColor,
                    UIColor(red: 0.45, green: 0.55, blue: 0.65, alpha: 1).cgColor
                ]
                
            case .mixedSnowSleet, .sleet, .icePellets:
                return [
                    UIColor(red: 0.5, green: 0.55, blue: 0.65, alpha: 1).cgColor,
                    UIColor(red: 0.6, green: 0.65, blue: 0.75, alpha: 1).cgColor,
                    UIColor(red: 0.4, green: 0.45, blue: 0.55, alpha: 1).cgColor
                ]
                
            case .hail, .mixedRainHail:
                return [
                    UIColor(red: 0.45, green: 0.5, blue: 0.6, alpha: 1).cgColor,
                    UIColor(red: 0.55, green: 0.6, blue: 0.7, alpha: 1).cgColor,
                    UIColor(red: 0.35, green: 0.4, blue: 0.5, alpha: 1).cgColor
                ]
                
            case .mist, .fog, .freezingFog, .haze, .smoky, .dust:
                return [
                    UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor,
                    UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor,
                    UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1).cgColor
                ]
                
            case .windy, .blustery, .breezy:
                return [
                    UIColor(red: 0.38, green: 0.48, blue: 0.58, alpha: 1).cgColor,
                    UIColor(red: 0.48, green: 0.58, blue: 0.68, alpha: 1).cgColor,
                    UIColor(red: 0.28, green: 0.38, blue: 0.48, alpha: 1).cgColor
                ]
                
            case .hot:
                return [
                    UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 1).cgColor,
                    UIColor(red: 1.0, green: 0.6, blue: 0.3, alpha: 1).cgColor,
                    UIColor(red: 0.8, green: 0.4, blue: 0.1, alpha: 1).cgColor
                ]
                
            case .cold:
                return [
                    UIColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 1).cgColor,
                    UIColor(red: 0.4, green: 0.6, blue: 0.8, alpha: 1).cgColor,
                    UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1).cgColor
                ]
                
            case .tornado, .tropicalStorm, .hurricane:
                return [
                    UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 1).cgColor,
                    UIColor(red: 0.25, green: 0.25, blue: 0.3, alpha: 1).cgColor,
                    UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1).cgColor
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
