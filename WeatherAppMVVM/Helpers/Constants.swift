//
//  Constants.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 28.10.2023.
//

import CoreFoundation
import CoreGraphics
import UIKit

extension String {
    static let dot = ". "
    static let today = "Today"
    static let degree = "º"
    static let dateFormat = "yyyyMMdd"
    static let currently = "Currently "
    static let max = "Max: "
    static let min = ", min: "
    static let space = " "
}

extension Int {
    static let one = 1
    static let ten = 10
    static let fifteen = 15
    static let pointTwo = 0.2
}

extension Float {
    static let one = 1
    static let ten = 10
    
    static let pointTwo: Float = 0.2
}

extension CGFloat {
    static let pointTwo: CGFloat = 0.2
    static let ten: CGFloat = 10
    static let fifteen: CGFloat = 15
    static let fourty: CGFloat = 40
}

extension CGColor {
    static let black = UIColor.black.cgColor
}

