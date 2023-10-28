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

final class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var currentPlaceLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    
    @IBOutlet weak var currentStatusLabel: UILabel!
    
    @IBOutlet weak var hourList: UICollectionView!
    @IBOutlet weak var weekList: UITableView!
    
    //MARK: - Private properties
    private let viewModel = MainViewControllerViewModel()
    private let locationManager = LocationManager.shared
    private let dateDecoder = DateDecoder.shared
    private let weatherDecoder = WeatherDecoder.shared
    private let bag = DisposeBag()

    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyVisualParameters()
        
        
        locationManager.getUserLocation { location in
            self.viewModel.getHourlyForecast()
            self.viewModel.getWeekForecast()
            
            self.bindHourlyForecast()
            self.bindWeekForecast()
            
            self.bindLabels()
            
            self.currentPlaceLabel.text = "CURRENT PLACE"
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    


   //MARK: RX bindings
    func bindHourlyForecast() {
        hourList.rx.setDelegate(self).disposed(by: bag)

        viewModel.hourlyForecast.bind(to: hourList.rx.items(cellIdentifier: CollectionViewCell.identifier, cellType: CollectionViewCell.self)) { row, item, cell in
            
            cell.configureTime(with: self.dateDecoder.setTime(by: item.timepoint))
            cell.configureImage(with: self.weatherDecoder.setWeatherImageTitle(from: item.weather))
            cell.configureTemperature(with: item.temperature)
            
        }.disposed(by: bag)
    }
    
    
    
    func bindWeekForecast() {
        weekList.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.weekForecast.bind(to: weekList.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { (row, item, cell) in
            
            cell.configureDay(with: self.dateDecoder.setDayOfTheWeek(from: item.date))
            cell.configureMinTemperature(with: item.temperature.min)
            cell.configureMaxTemperature(with: item.temperature.max)
            cell.configureImage(with: self.weatherDecoder.setWeatherImageTitle(from: item.weather))
        }.disposed(by: bag)
    }
    
    func bindLabels() {
        viewModel.hourlyForecast.bind { data in
            guard let temperature = data.first?.temperature else { return }
            
            DispatchQueue.main.async {
                self.currentTemperatureLabel.text = temperature.description + .degree
            }
        }.disposed(by: bag)
        
        
        viewModel.weekForecast.bind { data in
            guard let weatherData = data.first else { return }
            
            DispatchQueue.main.async {
                self.minMaxTemperatureLabel.text = .max + weatherData.temperature.max.description + .degree + .min + weatherData.temperature.min.description  + .degree
                self.currentWeatherLabel.text = self.weatherDecoder.setWeatherTitle(from: weatherData.weather).capitalized
                self.currentStatusLabel.text = .currently + self.weatherDecoder.setWeatherTitle(from: weatherData.weather) + .dot + self.weatherDecoder.setWindTitle(from: weatherData.wind10MMax)
            }
        }.disposed(by: bag)
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Flow
    private func applyVisualParameters() {
        view.setGradientBackground()
        
        currentTemperatureLabel.layer.shadowColor = .black
        currentTemperatureLabel.layer.shadowOpacity = .pointTwo
        currentTemperatureLabel.layer.shadowRadius = .ten
        
        currentWeatherLabel.layer.shadowColor = .black
        currentWeatherLabel.layer.shadowOpacity = .pointTwo
        currentWeatherLabel.layer.shadowRadius = .ten
        
        currentPlaceLabel.layer.shadowColor = .black
        currentPlaceLabel.layer.shadowOpacity = .pointTwo
        currentPlaceLabel.layer.shadowRadius = .ten
        
        minMaxTemperatureLabel.layer.shadowColor = .black
        minMaxTemperatureLabel.layer.shadowOpacity = .pointTwo
        minMaxTemperatureLabel.layer.shadowRadius = .ten
        
        
        hourList.layer.cornerRadius = .fifteen
        hourList.backgroundColor = .systemGray4.withAlphaComponent(.pointTwo)
        
        weekList.layer.cornerRadius = hourList.layer.cornerRadius
        weekList.backgroundColor = hourList.backgroundColor
    }
    
    
}

extension MainViewController: UITableViewDelegate { }
