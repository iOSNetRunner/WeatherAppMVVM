//
//  searchListCell.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 29.10.2023.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        contentView.addSubview(locationLabel)
        contentView.backgroundColor = .systemCyan
            locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        applyConstraints()
    }
    
    func configureLocationLabel(with string: String) {
        locationLabel.text = string
    }
    
    func applyConstraints() {
        locationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        locationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        
    }
    
    
}
