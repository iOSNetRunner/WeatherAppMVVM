//
//  ViewController.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 24.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {
    
    
    @IBOutlet weak var currentPlaceLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    private let viewModel = ViewModel()
    private let bag = DisposeBag()
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyVisualParameters()
        
        viewModel.getForecasts()
        bindTableView()
        bindCollectionView()
       
        
        
        
    }


   
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.forecasts.bind(to: tableView.rx.items(cellIdentifier: "cell")) { (row, item, cell) in
            
            cell.textLabel?.text = item.weather
            cell.detailTextLabel?.text = item.humidity
            
        }.disposed(by: bag)
        
        
    }
    
    func bindCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.forecasts.bind(to: collectionView.rx.items(cellIdentifier: "cell2", cellType: CollectionViewCell.self)) { row, item, cell in
            
            
            cell.configureTemperature(with: String(item.temperature))
            cell.configureTime(with: String(item.timepoint))
            
            
           
        }.disposed(by: bag)
    }
    
    
    
    
    
    
    
    
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

extension ViewController: UITableViewDelegate {
    
}





