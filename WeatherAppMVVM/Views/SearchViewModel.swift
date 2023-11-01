//
//  SearchViewModel.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 29.10.2023.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

final class SearchViewModel {
    
    var searchText = BehaviorRelay<String>(value: "")
    
    private let locationManager = LocationManager.shared
    
    
    var favouriteLocations: [Location] = []
    var inputLocations: [Location] = []
    
    var mainLocations = BehaviorSubject(value: [Location]())
    var favouriteLocationsBehaviour = BehaviorRelay(value: [Location]())
    
    
    func getLocations() {
        mainLocations.on(.next(inputLocations))
        
        Geocoder.findLocations(with: searchText.value, completion: { locations in
            self.inputLocations = locations
        })
    }
    
    func loadLocations() {
        favouriteLocationsBehaviour.accept(favouriteLocations)
        
    }
    
}
