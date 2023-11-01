//
//  LocationManager.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 27.10.2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    func requestAutorization(completion: @escaping ((Bool) -> Void)) {
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        if manager.authorizationStatus != .restricted {
            manager.startUpdatingLocation()
            return completion(true) }
    }
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
