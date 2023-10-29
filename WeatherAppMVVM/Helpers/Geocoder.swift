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
            guard let city = placemark?.first?.administrativeArea, error == nil else { return }
            completion(city)
        }
    }
    
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
        geocoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            
            let locations: [Location] = places.compactMap({ place in
                var name = ""
                
                if let title = place.name {
                    name += title
                }
                
                if let city = place.administrativeArea {
                    name += ", \(city)"
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                
                let result = Location(
                    title: name,
                    coordinate: place.location?.coordinate)
                return result
            })
            
            completion(locations)
        }
    }
    
    
}
