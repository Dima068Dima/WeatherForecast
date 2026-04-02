import Foundation

enum WeatherCondition: String {
    case sunny = "sunny"
    case clear = "clear"
    case fair = "fair"
    case mostlyClear = "mostly clear"
    case mostlySunny = "mostly sunny"
    
    case partlyCloudy = "partly cloudy"
    case cloudy = "cloudy"
    case mostlyCloudy = "mostly cloudy"
    case overcast = "overcast"
    
    case drizzle = "drizzle"
    case lightDrizzle = "light drizzle"
    case freezingDrizzle = "freezing drizzle"
    case lightRain = "light rain"
    case patchyRain = "patchy rain possible"
    case moderateRain = "moderate rain"
    case rain = "rain"
    case heavyRain = "heavy rain"
    case freezingRain = "freezing rain"
    case showers = "showers"
    case lightShowers = "light showers"
    case heavyShowers = "heavy showers"
    case thunderyShowers = "thundery showers"
    case amShowers = "am showers"
    case pmShowers = "pm showers"
    case amLightRain = "am light rain"
    case pmLightRain = "pm light rain"
    case rainSnowShowers = "rain snow showers"
    
    case thundershowers = "thundershowers"
    case thunderstorm = "thunderstorm"
    case thunderstormWithRain = "thunderstorm with rain"
    case severeThunderstorms = "severe thunderstorms"
    case isolatedThunderstorms = "isolated thunderstorms"
    case scatteredThunderstorms = "scattered thunderstorms"
    
    case snow = "snow"
    case lightSnow = "light snow"
    case moderateSnow = "moderate snow"
    case heavySnow = "heavy snow"
    case snowShowers = "snow showers"
    case lightSnowShowers = "light snow showers"
    case heavySnowShowers = "heavy snow showers"
    case snowFlurries = "snow flurries"
    case blizzard = "blizzard"
    case blowingSnow = "blowing snow"
    case mixedSnowSleet = "mixed snow sleet"
    case sleet = "sleet"
    case icePellets = "ice pellets"
    case hail = "hail"
    case mixedRainHail = "mixed rain hail"
    
    case mist = "mist"
    case fog = "fog"
    case freezingFog = "freezing fog"
    case haze = "haze"
    case smoky = "smoky"
    case dust = "dust"
    
    case windy = "windy"
    case blustery = "blustery"
    case breezy = "breezy"
    
    case hot = "hot"
    case cold = "cold"
    case tornado = "tornado"
    case tropicalStorm = "tropical storm"
    case hurricane = "hurricane"
    
    case unknown = "unknown"
    
    // MARK: - Init
    init(from string: String) {
        let lowercased = string.lowercased()
        
        switch lowercased {
            case let str where str.contains("sunny"):
                self = .sunny
            case let str where str == "clear":
                self = .clear
            case let str where str.contains("fair"):
                self = .fair
            case let str where str.contains("mostly clear"):
                self = .mostlyClear
            case let str where str.contains("mostly sunny"):
                self = .mostlySunny
                
            case let str where str.contains("partly cloudy"):
                self = .partlyCloudy
            case let str where str == "cloudy":
                self = .cloudy
            case let str where str.contains("mostly cloudy"):
                self = .mostlyCloudy
            case let str where str.contains("overcast"):
                self = .overcast
                
            case let str where str.contains("freezing drizzle"):
                self = .freezingDrizzle
            case let str where str.contains("light drizzle"):
                self = .lightDrizzle
            case let str where str.contains("drizzle"):
                self = .drizzle
            case let str where str.contains("freezing rain"):
                self = .freezingRain
            case let str where str.contains("torrential rain") || str.contains("heavy rain"):
                self = .heavyRain
            case let str where str.contains("am light rain"):
                self = .amLightRain
            case let str where str.contains("pm light rain"):
                self = .pmLightRain
            case let str where str.contains("light rain"):
                self = .lightRain
            case let str where str.contains("patchy rain possible"):
                self = .patchyRain
            case let str where str.contains("moderate rain"):
                self = .moderateRain
            case let str where str.contains("rain snow showers"):
                self = .rainSnowShowers
            case let str where str.contains("rain"):
                self = .rain
                
            case let str where str.contains("thundery showers"):
                self = .thunderyShowers
            case let str where str.contains("am showers"):
                self = .amShowers
            case let str where str.contains("pm showers"):
                self = .pmShowers
            case let str where str.contains("heavy showers"):
                self = .heavyShowers
            case let str where str.contains("light showers"):
                self = .lightShowers
            case let str where str.contains("showers"):
                self = .showers
                
            case let str where str.contains("thunderstorm with rain"):
                self = .thunderstormWithRain
            case let str where str.contains("severe thunderstorms"):
                self = .severeThunderstorms
            case let str where str.contains("isolated thunderstorms"):
                self = .isolatedThunderstorms
            case let str where str.contains("scattered thunderstorms"):
                self = .scatteredThunderstorms
            case let str where str.contains("thundershowers"):
                self = .thundershowers
            case let str where str.contains("thunder"):
                self = .thunderstorm
                
            case let str where str.contains("blizzard"):
                self = .blizzard
            case let str where str.contains("blowing snow"):
                self = .blowingSnow
            case let str where str.contains("heavy snow showers"):
                self = .heavySnowShowers
            case let str where str.contains("light snow showers"):
                self = .lightSnowShowers
            case let str where str.contains("snow showers"):
                self = .snowShowers
            case let str where str.contains("snow flurries"):
                self = .snowFlurries
            case let str where str.contains("heavy snow"):
                self = .heavySnow
            case let str where str.contains("light snow"):
                self = .lightSnow
            case let str where str.contains("moderate snow"):
                self = .moderateSnow
            case let str where str.contains("snow"):
                self = .snow
                
            case let str where str.contains("mixed snow sleet"):
                self = .mixedSnowSleet
            case let str where str.contains("ice pellets"):
                self = .icePellets
            case let str where str.contains("sleet"):
                self = .sleet
            case let str where str.contains("mixed rain hail"):
                self = .mixedRainHail
            case let str where str.contains("hail"):
                self = .hail
                
            case let str where str.contains("freezing fog"):
                self = .freezingFog
            case let str where str.contains("fog"):
                self = .fog
            case let str where str.contains("mist"):
                self = .mist
            case let str where str.contains("haze"):
                self = .haze
            case let str where str.contains("smoky"):
                self = .smoky
            case let str where str.contains("dust"):
                self = .dust
                
            case let str where str.contains("blustery"):
                self = .blustery
            case let str where str.contains("breezy"):
                self = .breezy
            case let str where str.contains("windy"):
                self = .windy
                
            case let str where str.contains("tornado"):
                self = .tornado
            case let str where str.contains("tropical storm"):
                self = .tropicalStorm
            case let str where str.contains("hurricane"):
                self = .hurricane
            case let str where str.contains("hot"):
                self = .hot
            case let str where str.contains("cold"):
                self = .cold
                
            default:
                self = .unknown
        }
    }
    
    // MARK: - Russian name
    var russianName: String {
        switch self {
            case .sunny: return "Солнечно"
            case .clear: return "Ясно"
            case .fair: return "Хорошо"
            case .mostlyClear: return "В основном ясно"
            case .mostlySunny: return "Малооблачно"
                
            case .partlyCloudy: return "Переменная облачность"
            case .cloudy: return "Облачно"
            case .mostlyCloudy: return "Значительная облачность"
            case .overcast: return "Пасмурно"
                
            case .drizzle: return "Морось"
            case .lightDrizzle: return "Слабая морось"
            case .freezingDrizzle: return "Ледяная морось"
            case .lightRain: return "Небольшой дождь"
            case .patchyRain: return "Местами дождь"
            case .moderateRain: return "Умеренный дождь"
            case .rain: return "Дождь"
            case .heavyRain: return "Сильный дождь"
            case .freezingRain: return "Ледяной дождь"
            case .showers: return "Ливни"
            case .lightShowers: return "Небольшие ливни"
            case .heavyShowers: return "Сильные ливни"
            case .thunderyShowers: return "Грозовые ливни"
            case .amShowers: return "Утром ливни"
            case .pmShowers: return "Днем ливни"
            case .amLightRain: return "Утром небольшой дождь"
            case .pmLightRain: return "Днем небольшой дождь"
            case .rainSnowShowers: return "Дождь со снегом"
                
            case .thundershowers: return "Грозовые ливни"
            case .thunderstorm: return "Гроза"
            case .thunderstormWithRain: return "Гроза с дождем"
            case .severeThunderstorms: return "Сильные грозы"
            case .isolatedThunderstorms: return "Местами грозы"
            case .scatteredThunderstorms: return "Отдельные грозы"
                
            case .snow: return "Снег"
            case .lightSnow: return "Небольшой снег"
            case .moderateSnow: return "Снег"
            case .heavySnow: return "Сильный снег"
            case .snowShowers: return "Снегопады"
            case .lightSnowShowers: return "Небольшие снегопады"
            case .heavySnowShowers: return "Сильные снегопады"
            case .snowFlurries: return "Снежные заряды"
            case .blizzard: return "Метель"
            case .blowingSnow: return "Позёмок"
            case .mixedSnowSleet: return "Снег с ледяной крупой"
            case .sleet: return "Ледяная крупа"
            case .icePellets: return "Ледяные гранулы"
            case .hail: return "Град"
            case .mixedRainHail: return "Дождь с градом"
                
            case .mist: return "Дымка"
            case .fog: return "Туман"
            case .freezingFog: return "Ледяной туман"
            case .haze: return "Мгла"
            case .smoky: return "Смог"
            case .dust: return "Пыль"
                
            case .windy: return "Ветрено"
            case .blustery: return "Штормовой ветер"
            case .breezy: return "Свежий ветер"
                
            case .hot: return "Жарко"
            case .cold: return "Холодно"
            case .tornado: return "Торнадо"
            case .tropicalStorm: return "Тропический шторм"
            case .hurricane: return "Ураган"
                
            case .unknown: return "Неизвестно"
        }
    }
}
