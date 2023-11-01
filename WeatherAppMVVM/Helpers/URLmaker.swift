//
//  URLmaker.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 27.10.2023.
//

import Foundation
import CoreLocation

final class URLMaker {
    
    static func generateURL(isForWeek: Bool, coordinate: CLLocationCoordinate2D?) -> URL {
        var lon = LocationManager.shared.manager.location?.coordinate.longitude
        var lat = LocationManager.shared.manager.location?.coordinate.latitude
        
        if coordinate != nil {
            lon = coordinate?.longitude
            lat = coordinate?.latitude
        }
        
        let baseURL = "https://www.7timer.info/"
        let apiAccess = "bin/api.pl?"
        let hourEndPoint = "lon=\(lon ?? .zero)&lat=\(lat ?? .zero)&product=civil&output=json"
        let weekEndPoint = "lon=\(lon ?? .zero)&lat=\(lat ?? .zero)&product=civillight&output=json"
        
        if isForWeek {
            return URL(string: baseURL + apiAccess + weekEndPoint)!
        } else {
            return URL(string: baseURL + apiAccess + hourEndPoint)!
        }
    }
}
