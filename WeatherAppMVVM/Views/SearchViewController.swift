//
//  SearchViewController.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 29.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    private let viewModel = SearchViewModel()
    private let searchController = UISearchController()

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        
        view.setGradientBackground()
        
        applyVisualParameters()
        
        view.addSubview(tableView)
        
        
        
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
                
               
                
                self.viewModel.getLocations()
                
                self.tableView.rx.setDelegate(self).disposed(by: DisposeBag())
                
                
                self.viewModel.mainLocations.bind(to: self.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier , cellType: SearchTableViewCell.self)) { row, item, cell in
                    cell.configureLocationLabel(with: item.title)
                    
                    
                    
                    
                    
                }.disposed(by: DisposeBag())
                
                
                
                self.tableView.rx.modelSelected(Location.self).subscribe(onNext: { item in
                    print("HEY SELECTED! \(item.title)")
                }).disposed(by: DisposeBag())
                
                
            }
            
            
            
            
            
        }
    }


extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}


