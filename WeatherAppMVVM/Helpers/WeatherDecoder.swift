//
//  WeatherDecoder.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 28.10.2023.
//

import UIKit

final class WeatherDecoder {
    
    static let shared = WeatherDecoder()
    
    private init () {}
    
    func setWeatherTitle(from data: String) -> String {
        switch data {
        case "pcloudy": return "partly cloudy"
        case "mcloudy": return "cloudy"
        case "cloudy": return "very cloudy"
        case "humid": return "foggy"
        case "lightrain": return "light rain or showers"
        case "oshower": return "Occasional showers"
        case "ishower": return "Isolated showers"
        case "lightsnow": return "light snow"
        case "rain": return "rainy"
        case "snow": return "snow"
        case "rainsnow": return "freezing rain or icepellets"
        case "ts": return "thunderstorm"
        case "tsrain": return "rainy thunderstorm"
        case "windy": return "windy"
        default: return "clear"
        }
    }
    
    func setWeatherImageTitle(from data: String) -> String {
        switch data {
        case "pcloudy", "pcloudynight", "pcloudyday": return "cloud.sun.fill"
        case "mcloudy", "mcloudynight", "mcloudyday": return "cloud.fill"
        case "cloudy", "cloudynight", "cloudyday": return "smoke.fill"
        case "humid", "humidnight", "humidday": return "cloud.fog.fill"
        case "lightrain", "lightrainnight", "lightrainday": return "cloud.drizzle.fill"
        case "oshower", "oshowernight", "oshowerday": return "cloud.sun.rain.fill"
        case "ishower", "ishowernight", "ishowerday": return "cloud.heavyrain.fill"
        case "lightsnow", "lightsnownight", "lightsnowday": return "cloud.snow.fill"
        case "rain", "rainnight", "rainday": return "cloud.rain.fill"
        case "snow", "snownight", "snowday": return "cloud.sleet.fill"
        case "rainsnow", "rainsnownight", "rainsnowday": return "cloud.hail.fill"
        case "ts", "tsnight", "tsday": return "cloud.bolt.fill"
        case "tsrain", "tsrainnight", "tsrainday": return "cloud.bolt.rain.fill"
        case "windy", "windyday", "windynight": return "wind"
        default: return "sun.max.fill"
        }
    }
    
    func setWindTitle(from data: Int) -> String {
        switch data {
        case 1: return "Wind gusts below 0.3 m/s."
        case 2: return "Wind gusts are up to 0.3-3.4 m/s."
        case 3: return "Wind gusts are up to 3.4-8.0 m/s."
        case 4: return "Wind gusts are up to 8.0-10.8 m/s."
        case 5: return "Wind gusts are up to 10.8-17.2 m/s."
        case 6: return "Wind gusts are up to 17.2-24.5 m/s."
        case 7: return "Wind gusts are up to 24.5-32.6 m/s."
        default: return "Wind gusts over 32.6 m/s."
        }
    }
    
}
