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
    let geoCoder = CLGeocoder()
    
    var completion: ((CLLocation) -> Void)?
    var lastLocation: String?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.stopUpdatingLocation()
    }
    
    func getLocation(from location: CLLocation, completion: @escaping (String) -> Void) {
        
        geoCoder.reverseGeocodeLocation(location) { placemark, error in
            guard let city = placemark?.first?.administrativeArea else { return }
            completion(city)
        }
     
        
    }
}
