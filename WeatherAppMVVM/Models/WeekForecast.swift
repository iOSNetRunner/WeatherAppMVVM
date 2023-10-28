//
//  WeekForecast.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 27.10.2023.
//



// MARK: - Week Forecast
struct WeekForecast: Codable {
    let data: [WeekData]

    enum CodingKeys: String, CodingKey {
        case data = "dataseries"
    }
}

// MARK: - Week Data
struct WeekData: Codable {
    let date: Int
    let weather: String
    let temperature: Temperature
    let wind10MMax: Int

    enum CodingKeys: String, CodingKey {
        case date, weather
        case temperature = "temp2m"
        case wind10MMax = "wind10m_max"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    let max: Int
    let min: Int
}
