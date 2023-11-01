//
//  Geocoder.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 28.10.2023.
//

import CoreLocation

final class Geocoder {
    
    static func getLocationTitle(from location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemark, error in
            guard let city = placemark?.first?.administrativeArea,
                  let country = placemark?.first?.country,
                  let area = placemark?.first?.locality,
                  error == nil else { return }
            
            let title = "\(area), \(city), \(country)"
            completion(title)
        }
    }
    
    static func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
        let geocoder = CLGeocoder()
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
                    coordinate: place.location?.coordinate,
                    location: place.location)
                
                return result
                
            })
            completion(locations)
        }
    }
}
