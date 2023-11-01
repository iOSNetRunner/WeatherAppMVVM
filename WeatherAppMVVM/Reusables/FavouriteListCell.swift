//
//  FavouriteListCell.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 01.11.2023.
//

import UIKit

final class FavouriteListCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.sun.rain.fill")?.withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .systemGray4
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        contentView.backgroundColor = .cyan
        contentView.setGradientBackground()
        contentView.addSubview(titleLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(minTemperatureLabel)
        contentView.addSubview(maxTemperatureLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        applyConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        minTemperatureLabel.text = nil
        maxTemperatureLabel.text = nil
        weatherImageView.image = nil
    }
    
    func configureTitle(with string: String) {
        titleLabel.text = string
    }
    
    func configureImage(with string: String) {
        weatherImageView.image = UIImage(systemName: string)?.withRenderingMode(.alwaysOriginal)
    }
    
    func configureMinTemperature(with int: Int) {
        minTemperatureLabel.text = String(int) + "º"
    }
    
    func configureMaxTemperature(with int: Int) {
        maxTemperatureLabel.text = String(int) + "º"
    }
    
    func applyConstraints() {
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        minTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        maxTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        weatherImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 100).isActive = true
        minTemperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -150).isActive = true
        maxTemperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    }
    
}
