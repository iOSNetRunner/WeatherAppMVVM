//
//  ViewController.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 24.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class MainViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var currentPlaceLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    
    @IBOutlet weak var currentStatusLabel: UILabel!
    
    @IBOutlet weak var hourList: UICollectionView!
    @IBOutlet weak var weekList: UITableView!
    
    //MARK: - Private properties
    private var isAuthorized = false
    private let viewModel = MainViewControllerViewModel.shared
    private let dateDecoder = DateDecoder.shared
    private let bag = DisposeBag()
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        applyVisualParameters()
        
        viewModel.requestAuthorization()
        
        viewModel.cityTitleBehavior.subscribe { text in
            self.currentPlaceLabel.text = text
        }.disposed(by: bag)
    }
    
    
    func getAccess() {
        viewModel.getHourlyForecast()
        viewModel.getWeekForecast()
        
        bindHourlyForecast()
        bindWeekForecast()
        
        bindLabels()
    }
    
    //MARK: RX bindings
    private func bindHourlyForecast() {
        hourList.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.hourlyForecast.bind(to: hourList.rx.items(cellIdentifier: CollectionViewCell.identifier, cellType: CollectionViewCell.self)) { row, item, cell in
            
            cell.configureTime(with: self.dateDecoder.setTime(by: item.timepoint))
            cell.configureImage(with: WeatherDecoder.setWeatherImageTitle(from: item.weather))
            cell.configureTemperature(with: item.temperature)
            
        }.disposed(by: bag)
    }
    
    
    
    private func bindWeekForecast() {
        weekList.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.weekForecast.bind(to: weekList.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { (row, item, cell) in
            
            cell.configureDay(with: self.dateDecoder.setDayOfTheWeek(from: item.date))
            cell.configureMinTemperature(with: item.temperature.min)
            cell.configureMaxTemperature(with: item.temperature.max)
            cell.configureImage(with: WeatherDecoder.setWeatherImageTitle(from: item.weather))
        }.disposed(by: bag)
    }
    
    
    private func bindLabels() {
        viewModel.hourlyForecast.bind { data in
            guard let temperature = data.first?.temperature else { return }
            
            DispatchQueue.main.async {
                self.currentTemperatureLabel.text = .space + temperature.description + .degree
            }
        }.disposed(by: bag)
        
        
        viewModel.weekForecast.bind { data in
            guard let weatherData = data.first else { return }
            
            DispatchQueue.main.async {
                self.minMaxTemperatureLabel.text = .max + weatherData.temperature.max.description + .degree + .min + weatherData.temperature.min.description  + .degree
                self.currentWeatherLabel.text = WeatherDecoder.setWeatherTitle(from: weatherData.weather).capitalized
                self.currentStatusLabel.text = .currently + WeatherDecoder.setWeatherTitle(from: weatherData.weather) + .dot + WeatherDecoder.setWindTitle(from: weatherData.wind10MMax)
            }
        }.disposed(by: bag)
    }
    
    
    //MARK: - Flow
    private func applyVisualParameters() {
        view.setGradientBackground()
        
        weekList.rowHeight = .fourty
        
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
