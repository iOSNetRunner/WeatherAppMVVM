//
//  DateDecoder.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 28.10.2023.
//
import Foundation

final class DateDecoder {
    
    static let shared = DateDecoder()
    
    private init () {}
    
    private let formatter = DateFormatter()
    
    //MARK: - Get weekday from date
    func setDayOfTheWeek(from data: Int) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = .dateFormat
        
        guard let date = formatter.date(from: String(data)) else { return "" }
        
        let calendar = Calendar(identifier: .gregorian)
        let weekDayIndex = calendar.component(.weekday, from: date)
        let weekDay = formatter.shortWeekdaySymbols[weekDayIndex - .one]
        
        let currentDate = formatter.string(from: Date())
        let firstDate = formatter.date(from: currentDate)
        
        return firstDate == date ? .today : weekDay
    }
    
    //MARK: - Forecast time by timepoint
    func setTime(by timepoint: Int) -> String {
        
        let formatter = DateFormatter()
        let currentDate = Date()
        let calendar = Calendar(identifier: .gregorian)
        
        formatter.timeStyle = .short
        formatter.dateStyle = .none
    
        guard let futureTime = calendar.date(byAdding: .hour, value: timepoint, to: currentDate) else { return "" }
        let time = formatter.string(from: futureTime)
        
        return time
    }
}
