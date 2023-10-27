//
//  ViewModel.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 25.10.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewModel {
    
    var forecasts = BehaviorSubject(value: [Data]())
    
    
    func getForecasts() {
        let url = URL(string: "https://www.7timer.info/bin/api.pl?lon=113.17&lat=23.09&product=civil&output=json")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                print("guard nope")
                return
            }
            do {
                
                let responseData = try JSONDecoder().decode(HourForecast.self, from: data)
                self.forecasts.on(.next(responseData.data))
                
                
            } catch {
                
                print(error)
            }
        }
        task.resume()
    }
    
}
