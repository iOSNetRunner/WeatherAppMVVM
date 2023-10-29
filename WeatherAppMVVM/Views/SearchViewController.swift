//
//  SearchViewController.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 29.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewController: UIViewController, UISearchResultsUpdating, UIScrollViewDelegate {
    
    private let viewModel = SearchViewModel()
    
    
   
    
    
    private let searchController = UISearchController()
    
    
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground()
        
        applyVisualParameters()
        
        view.addSubview(tableView)
        
        
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       // let tableY: CGFloat = searchController.searchBar.frame.origin.y + searchController.searchBar.frame.size.height + 5
        
        tableView.frame = searchController.searchBar.frame
        tableView.rowHeight = .fourty
        tableView.backgroundColor = .clear
        
    }
        
    
        
        
        
        
        
        
        private func applyVisualParameters() {
            navigationItem.searchController = searchController
            searchController.searchBar.placeholder = .searchPlaceholder
            searchController.searchResultsUpdater = self
            
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            guard let text = searchController.searchBar.text else { return }
            
            Geocoder.shared.findLocations(with: text) { locations in
                
                self.viewModel.inputLocations = locations
                
                print(self.viewModel.inputLocations)
                
                self.viewModel.getLocations()
                
                self.tableView.rx.setDelegate(self).disposed(by: DisposeBag())
                
                self.viewModel.mainLocations.bind(to: self.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier , cellType: SearchTableViewCell.self)) { row, item, cell in
                    cell.configureLocationLabel(with: item.title)
                    
                    
                }.disposed(by: DisposeBag())
                
                
                
            }
            
            
            
            
            
        }
    }


extension SearchViewController: UITableViewDelegate { }
