//
//  ViewModel.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 25.10.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

final class MainViewControllerViewModel {
    
    let hourlyForecast = BehaviorSubject(value: [Data]())
    let weekForecast = BehaviorSubject(value: [WeekData]())
    
    func getHourlyForecast() {
        let url = URLMaker.generateURL(isForWeek: false)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let responseData = try JSONDecoder().decode(HourForecast.self, from: data)
                self.hourlyForecast.on(.next(responseData.data))
                
            } catch {
                
                print(error)
            }
        }
        task.resume()
    }
    
    
    
    func getWeekForecast() {
        let url = URLMaker.generateURL(isForWeek: true)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let responseData = try JSONDecoder().decode(WeekForecast.self, from: data)
                self.weekForecast.on(.next(responseData.data))
                
            } catch {
                
                print(error)
            }
        }
        task.resume()
    
    }
    
}
