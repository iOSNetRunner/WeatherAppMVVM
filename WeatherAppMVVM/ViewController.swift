//
//  ViewController.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 24.10.2023.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

final class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var currentPlaceLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    
    
    @IBOutlet weak var currentStatusLabel: UILabel!
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    private let viewModel = ViewModel()
    private let locationManager = LocationManager.shared
    private let bag = DisposeBag()

    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyVisualParameters()
        
        
        
        locationManager.getUserLocation { location in
            self.viewModel.getHourlyForecast()
            self.viewModel.getWeekForecast()
            
            self.bindCollectionView()
            self.bindTableView()
            
            self.bindLabels()
            
            self.currentPlaceLabel.text = location.coordinate.latitude.description + " | " + location.coordinate.longitude.description
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    


   //MARK: RX bindings
    func bindCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.hourlyForecast.bind(to: collectionView.rx.items(cellIdentifier: CollectionViewCell.identifier, cellType: CollectionViewCell.self)) { row, item, cell in
            
            cell.configureTemperature(with: item.temperature)
            cell.configureTime(with: item.timepoint)
        }.disposed(by: bag)
    }
    
    
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.weekForecast.bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { (row, item, cell) in
            
            cell.configureDay(with: item.date)
            cell.configureMinTemperature(with: item.temperature.min)
            cell.configureMaxTemperature(with: item.temperature.max)
        }.disposed(by: bag)
    }
    
    func bindLabels() {
        viewModel.hourlyForecast.bind { data in
            guard let temperature = data.first?.temperature else { return }
            DispatchQueue.main.async {
                self.currentTemperatureLabel.text = temperature.description + "º"
            }
        }.disposed(by: bag)
        
        
        viewModel.weekForecast.bind { data in
            guard let weatherData = data.first else { return }
            DispatchQueue.main.async {
                self.minMaxTemperatureLabel.text = "Max: " + weatherData.temperature.max.description + "º" + ", min: " + weatherData.temperature.min.description  + "º"
                self.currentWeatherLabel.text = weatherData.weather
                self.currentStatusLabel.text = "Currently " + weatherData.weather + ". Wind up to " + weatherData.wind10MMax.description + "m/s."
                
            }
        }.disposed(by: bag)
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Flow
    private func applyVisualParameters() {
        view.setGradientBackground()
        
        currentTemperatureLabel.layer.shadowColor = UIColor.black.cgColor
        currentTemperatureLabel.layer.shadowOpacity = 0.2
        currentTemperatureLabel.layer.shadowRadius = 10
        
        currentWeatherLabel.layer.shadowColor = UIColor.black.cgColor
        currentWeatherLabel.layer.shadowOpacity = 0.2
        currentWeatherLabel.layer.shadowRadius = 10
        
        currentPlaceLabel.layer.shadowColor = UIColor.black.cgColor
        currentPlaceLabel.layer.shadowOpacity = 0.2
        currentPlaceLabel.layer.shadowRadius = 10
        
        minMaxTemperatureLabel.layer.shadowColor = UIColor.black.cgColor
        minMaxTemperatureLabel.layer.shadowOpacity = 0.2
        minMaxTemperatureLabel.layer.shadowRadius = 10
        
        
        collectionView.layer.cornerRadius = 15
        collectionView.backgroundColor = .systemGray4.withAlphaComponent(0.2)
        
        tableView.layer.cornerRadius = collectionView.layer.cornerRadius
        tableView.backgroundColor = collectionView.backgroundColor
        
        
    }
    
    
}

extension ViewController: UITableViewDelegate { }





