//
//  CollectionViewCell.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 27.10.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        
        return label
    }()
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(timeLabel)
        contentView.addSubview(temperatureLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    func configureTemperature(with string: String) {
        temperatureLabel.text = string + "℃"
    }
    
    func configureTime(with string: String) {
        timeLabel.text = string
    }
    
}
