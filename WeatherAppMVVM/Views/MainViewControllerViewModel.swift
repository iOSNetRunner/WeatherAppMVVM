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
    
    static let shared = MainViewControllerViewModel()
    
    private let locationManager = LocationManager.shared
    
    let hourlyForecast = BehaviorSubject(value: [Data]())
    let weekForecast = BehaviorSubject(value: [WeekData]())
    
    var cityTitleBehavior = BehaviorRelay(value: "")
    
    var selectedLocation: Location?
    var chosenCoordinate: CLLocationCoordinate2D?
    
    weak var delegate: MainViewController?
    
    private init () {}
    
    func updateCityTitle() {
        guard let location = selectedLocation?.location else { return }
        Geocoder.getLocationTitle(from: location) { text in
                self.cityTitleBehavior.accept(text)
        }
    }
    
    func requestAuthorization() {
        self.locationManager.requestAutorization { bool in
            if bool {
                self.locationManager.getUserLocation { location in
                    self.delegate?.getAccess()
                    
                    Geocoder.getLocationTitle(from: location) { text in
                        self.cityTitleBehavior.accept(text)
                        
                    }
                }
            }
        }
    }

    func getHourlyForecast() {
        let url = URLMaker.generateURL(isForWeek: false, coordinate: chosenCoordinate)
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
        let url = URLMaker.generateURL(isForWeek: true, coordinate: chosenCoordinate)
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
