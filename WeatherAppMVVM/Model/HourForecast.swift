//
//  HourForecast.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 26.10.2023.
//


// MARK: - Forecast hour-by-hour
struct HourForecast: Codable {
    let data: [Data]

    enum CodingKeys: String, CodingKey {
        case data = "dataseries"
    }
}

// MARK: - Forecast Data
struct Data: Codable {
    let timepoint: Int
    let cloudcover: Int
    let precipitation: PrecType
    let temperature: Int
    let humidity: String
    let wind: Wind
    let weather: String

    enum CodingKeys: String, CodingKey {
        case timepoint, cloudcover
        case precipitation = "prec_type"
        case temperature = "temp2m"
        case humidity = "rh2m"
        case wind = "wind10m"
        case weather
    }
}

enum PrecType: String, Codable {
    case none = "none"
    case rain = "rain"
    case freezingRain = "frzr"
    case icePellets = "icep"
    case snow
}

// MARK: - Wind
struct Wind: Codable {
    let direction: String
    let speed: Int
}
