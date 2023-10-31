//
//  URLmaker.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 27.10.2023.
//

import Foundation
import CoreLocation

final class URLMaker {
    
    static func generateURL(isForWeek: Bool, with coordinate: CLLocationCoordinate2D? = nil)  -> URL {
        
        var geoCoordinate: CLLocationCoordinate2D?
        
        if coordinate == nil {
            
            geoCoordinate = LocationManager.shared.manager.location?.coordinate
        } else { geoCoordinate = coordinate }
        
        let lon = geoCoordinate?.longitude
        let lat = geoCoordinate?.latitude
            
        
        
        let baseURL = "https://www.7timer.info/"
        let apiAccess = "bin/api.pl?"
        let hourEndPoint = "lon=\(lon ?? .zero)&lat=\(lat ?? .zero)&product=civil&output=json"
        let weekEndPoint = "lon=\(lon ?? .zero)&lat=\(lat ?? .zero)&product=civillight&output=json"
        
        if isForWeek {
            print(baseURL + apiAccess + weekEndPoint)
            return URL(string: baseURL + apiAccess + weekEndPoint)!
        } else {
            return URL(string: baseURL + apiAccess + hourEndPoint)!
        }
    }
}
