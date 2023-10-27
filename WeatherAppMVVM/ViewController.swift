//
//  ViewController.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 24.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var viewModel = ViewModel()
    private var bag = DisposeBag()
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
    
    
    
    
}

extension ViewController: UITableViewDelegate {
    
}





