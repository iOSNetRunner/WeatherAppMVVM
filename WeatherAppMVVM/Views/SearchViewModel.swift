//
//  SearchViewModel.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 29.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewModel {
    
    var inputLocations: [Location] = []
    
    var mainLocations = BehaviorSubject(value: [Location]())
    
    
    func getLocations() {
        self.mainLocations.on(.next(inputLocations))
    }
    
}
