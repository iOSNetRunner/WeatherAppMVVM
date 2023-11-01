//
//  Location.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 29.10.2023.
//

import Foundation
import CoreLocation

struct Location {
    let title: String
    let coordinate: CLLocationCoordinate2D?
    let location: CLLocation?
}
