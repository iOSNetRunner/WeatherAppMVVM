//
//  SearchViewController.swift
//  WeatherAppMVVM
//
//  Created by Dmitrii Galatskii on 29.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    private let viewModel = SearchViewModel()
    private let searchController = UISearchController()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground()
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = .searchPlaceholder
        view.addSubview(tableView)
        
        searchController.searchResultsUpdater = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = searchController.searchBar.frame
        tableView.rowHeight = .fourty
        tableView.backgroundColor = .clear
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText).disposed(by: DisposeBag())
        
        self.viewModel.getLocations()
        
        self.viewModel.mainLocations.bind(to: self.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { row, item, cell in
            cell.configureLocationLabel(with: item.title)
        }.disposed(by: DisposeBag())
    }
}


extension SearchViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = viewModel.inputLocations.first else { return }
        
        viewModel.favouriteLocations.append(location)
        print(viewModel.favouriteLocations)
        
        MainViewControllerViewModel.shared.chosenCoordinate = viewModel.inputLocations.first?.coordinate
        MainViewControllerViewModel.shared.selectedLocation = viewModel.inputLocations.first
        
        
        MainViewControllerViewModel.shared.updateCityTitle()
        MainViewControllerViewModel.shared.getHourlyForecast()
        MainViewControllerViewModel.shared.getWeekForecast()
        
        tabBarController?.selectedIndex = .zero
    }
}
