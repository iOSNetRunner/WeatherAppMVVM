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
    private let currentDate = Date()
    private let calendar = Calendar(identifier: .gregorian)
    
    //MARK: - Get weekday from date
    func setDayOfTheWeek(from data: Int) -> String {
        
        formatter.dateFormat = .dateFormat
        
        guard let inputDate = formatter.date(from: String(data)) else { return "" }
        
        let weekDayIndex = calendar.component(.weekday, from: inputDate) - .one
        let weekDay = formatter.shortWeekdaySymbols[weekDayIndex]
        
        let currentDate = formatter.string(from: currentDate)
        let firstDate = formatter.date(from: currentDate)
        
        return firstDate == inputDate ? .today : weekDay
    }
    
    //MARK: - Forecast time by timepoint
    func setTime(by timepoint: Int) -> String {
        
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        guard let futureTime = calendar.date(byAdding: .hour, value: timepoint, to: currentDate) else { return "" }
        
        guard let clearedTime = calendar.date(bySetting: .minute, value: .zero, of: futureTime) else { return "" }
        
        let time = formatter.string(from: clearedTime)
        
        return time
    }
}
