//
//  Geocoder.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 28.10.2023.
//

import CoreLocation

final class Geocoder {
    static let shared = Geocoder()
    
    let geocoder = CLGeocoder()
    
    private init () {}
    
    func getLocationTitle(from location: CLLocation, completion: @escaping (String) -> Void) {
        
        geocoder.reverseGeocodeLocation(location) { placemark, error in
            guard let city = placemark?.first?.administrativeArea else { return }
            completion(city)
        }
     
        
    }
    
    
}
