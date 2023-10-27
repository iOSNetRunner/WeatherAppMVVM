//
//  CollectionViewCell.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 27.10.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.image = UIImage(systemName: "cloud.sun.fill")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        
        return label
    }()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        configureConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
       // weatherImageView.image = nil
        temperatureLabel.text = nil
    }
    
    func configureTemperature(with int: Int) {
        temperatureLabel.text = String(int) + "º"
    }
    
    func configureTime(with int: Int) {
        timeLabel.text = String(int)
    }
    
    func configureConstraints() {
        timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        
        temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 10).isActive = true
    }
    
}
